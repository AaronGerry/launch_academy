require_relative 'gameboard_row'
require_relative 'gameboard_space'

class Gameboard
  attr_reader :rows, :columns, :grid

  def initialize(row_count, column_count, mine_count)
    @rows = row_count
    @columns = column_count
    @mine_count = mine_count
    @grid = nil
  end

  def set_gameboard
    self.generate_grid
    self.create_mines
    self.create_blank_spaces
    self.place_pieces
    self.count_adjacent_mines
  end

  def generate_grid
    @rows.times do |row|
      row = GameboardRow.new
      @columns.times do |col|
        row.spaces_array << nil
      end
      if @grid.nil?
        @grid = []
        @grid << row
      else
        @grid << row
      end
    end
    @grid
  end

  def place_pieces
    mines = self.create_mines
    not_mines = self.create_blank_spaces
    all_spaces = mines + not_mines
    self.assign_coordinates(all_spaces.shuffle!)
  end

  def assign_coordinates(gameboard_pieces)
    @grid.each_with_index do |row, row_index|
      row.spaces_array.each_with_index do |space, col_index|
        current_gameboard_space = gameboard_pieces.pop
        if current_gameboard_space.x_coord.nil?
          current_gameboard_space.x_coord = col_index
          row.spaces_array[col_index] = current_gameboard_space
        end
        if current_gameboard_space.y_coord.nil?
          current_gameboard_space.y_coord = row_index
          row.spaces_array[col_index] = current_gameboard_space
        end
      end
    end
    @grid
  end

  def create_mines
    mine_game_spaces = []
    @mine_count.times do |mine|
      mine = GameboardSpace.new(true)
      mine_game_spaces << mine
    end
    mine_game_spaces
  end

  def create_blank_spaces
    blank_spaces = []
    total_spots = @rows * @columns - @mine_count
    total_spots.times do |not_mine|
      not_mine = GameboardSpace.new(false)
      blank_spaces << not_mine
    end
    blank_spaces
  end

  def user_move(row, col)
    if @grid[row].spaces_array[col].state == :unclicked
      @grid[row].spaces_array[col].state = :clicked
    end
    @grid[row].spaces_array[col]
  end

  def count_adjacent_mines
    # 1) Check adjacent space
    # 2) check if space exists
    # 3) check if unclicked and not a mine...

    @grid.each do |row|
      row.spaces_array.each do |space|
        adjacent_spaces = []
                # always the same pattern:
                  # (row - 1, (x - 1, x, x + 1))
                  # (row, (x - 1, x + 1))
                  # (row + 1, (x - 1, x, x + 1))

        # above
        if space.y_coord - 1 >= 0
            adjacent_spaces << @grid[space.x_coord].spaces_array[space.y_coord -
              1]
          if space.x_coord - 1 >= 0
            adjacent_spaces << @grid[space.x_coord -
              1].spaces_array[space.y_coord - 1]
          end
          if space.x_coord + 1 <= @columns - 1
            adjacent_spaces << @grid[space.x_coord +
              1].spaces_array[space.y_coord - 1]
          end
        end
        # same row
        if space.x_coord - 1 >= 0
          adjacent_spaces << @grid[space.x_coord - 1].spaces_array[space.y_coord]
        end
        if space.x_coord + 1 <= @columns - 1
          adjacent_spaces << @grid[space.x_coord + 1].spaces_array[space.y_coord]
        end
        # below
        if space.y_coord + 1 <= @rows - 1
          adjacent_spaces << @grid[space.x_coord].spaces_array[space.y_coord + 1]
          if space.x_coord - 1 >= 0
            adjacent_spaces << @grid[space.x_coord - 1].spaces_array[space.y_coord + 1]
          end
          if space.x_coord + 1 <= @columns - 1
            adjacent_spaces << @grid[space.x_coord + 1].spaces_array[space.y_coord + 1]
          end
        end
      space.adjacent_mines = adjacent_spaces.count{ |space| space.mine == true }
      end
    end
  end

private
  attr_reader :mine_count

end
