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
          current_gameboard_space.x_coord = row_index
          row.spaces_array[col_index] = current_gameboard_space
        end
        if current_gameboard_space.y_coord.nil?
          current_gameboard_space.y_coord = col_index
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

    # create adjacent cells
    # remove ones that are out of bounds
    # check remaining for mines


    @grid.each do |row|
      row.spaces_array.each do |space|
        # row above
        # can't allow it to check a negative number, it will just start at the back of the array...

        @grid[space.x_coord].spaces_array[(space.y_coord - 1)..(space.y_coord + 1)].each do |adjacent_space|
          binding.pry
          if adjacent_space.include?(x_coord)
            if adjacent_space.mine == true
              space.adjacent_mines += 1
            end
          end
        end
      end
      binding.pry
    end
  end
        # if space.x_coord ==

      # if space.exist? # if true
        # if @grid[row - 1].spaces_array[col -1].state == :unclicked
        #   && @grid[row - 1].spaces_array[col -1].mine == false
        #   @grid[row - 1].spaces_array[col -1].state == :clicked

    # @grid[row - 1].spaces_array[(col - 1)..(col + 1)].each do |space|
      # if space.exists?
        # if space.state == :unclicked && space.mine == false
          # space.state = :clicked
        # elsif space.state == :unclicked && space.mine == true
          # adjacent_mines += 1

          # row.spaces_array.map! { |space| space = all_spaces.pop }


        # always the same pattern:
          # (row - 1, (x - 1, x, x + 1))
          # (row, (x - 1, x + 1))
          # (row + 1, (x - 1, x, x + 1))

          # @grid[0-1] starts 1 from the last row

            # @grid[row].spaces_array[(col - 1), (col + 1) >> not going to work].each do |space|
            #   if space.exist?
            #     @grid[row].spaces_array[col].adjacent_mines += 1
            #   end
            # @grid[row + 1].spaces_array[(col - 1)..(col + 1)].each do |space|
            #   if space.exist?
            #     @grid[row].spaces_array[col].adjacent_mines += 1
            #   end

            #adjacent_mines = adjacent_spaces.count{ |space| space.mine == true } => returns number

          # .find_all with mine == true to get count
          # or .count mine == true >> is there a way to pull out each space object, then count those spaces for number?
            # if adjacent_spaces << if space.exist? == true

        # x - 1, y - 1 (top left)
        # x, y - 1 (top middle)
        # x + 1, y -1 (top right)
        # x - 1, y (middle left)
        # x + 1, y (middle right)
        # x - 1, y + 1 (bottom left)
        # x, y + 1 (bottom middle)
        # x + 1, y + 1 (bottom right)

private
  attr_reader :mine_count

end
