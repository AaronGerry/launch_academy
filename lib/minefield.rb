require_relative 'gameboard_space'
require_relative 'gameboard_row'
require 'pry'

class Minefield
  attr_reader :row_count, :column_count, :mine_count

  def initialize(row_count, column_count, mine_count)
    @row_count = row_count
    @column_count = column_count
    @mine_count = mine_count
    @gameboard = self.set_gameboard
  end

  def set_gameboard
    self.generate_gameboard
    self.create_mines
    self.create_blank_spaces
    self.place_pieces
    self.count_adjacent_mines
  end

  def generate_gameboard
    @row_count.times do |row|
      row = GameboardRow.new
      @column_count.times do |col|
        row.spaces_array << nil
      end
      if @gameboard.nil?
        @gameboard = []
        @gameboard << row
      else
        @gameboard << row
      end
    end
    @gameboard
  end

  def place_pieces
    mines = self.create_mines
    not_mines = self.create_blank_spaces
    all_spaces = mines + not_mines
    self.assign_coordinates(all_spaces.shuffle!)
  end

  def assign_coordinates(gameboard_pieces)
    @gameboard.each_with_index do |row, row_index|
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
    @gameboard
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
    total_spots = @row_count * @column_count - @mine_count
    total_spots.times do |not_mine|
      not_mine = GameboardSpace.new(false)
      blank_spaces << not_mine
    end
    blank_spaces
  end

  def count_adjacent_mines
    @gameboard.each do |row|
      row.spaces_array.each do |space|
        adjacent_spaces = []
        # above
        if space.y_coord - 1 >= 0
            adjacent_spaces << @gameboard[space.x_coord].spaces_array[space.y_coord -
              1]
          if space.x_coord - 1 >= 0
            adjacent_spaces << @gameboard[space.x_coord -
              1].spaces_array[space.y_coord - 1]
          end
          if space.x_coord + 1 <= @column_count - 1
            adjacent_spaces << @gameboard[space.x_coord +
              1].spaces_array[space.y_coord - 1]
          end
        end
        # same row
        if space.x_coord - 1 >= 0
          adjacent_spaces << @gameboard[space.x_coord - 1].spaces_array[space.y_coord]
        end
        if space.x_coord + 1 <= @column_count - 1
          adjacent_spaces << @gameboard[space.x_coord + 1].spaces_array[space.y_coord]
        end
        # below
        if space.y_coord + 1 <= @row_count - 1
          adjacent_spaces << @gameboard[space.x_coord].spaces_array[space.y_coord + 1]
          if space.x_coord - 1 >= 0
            adjacent_spaces << @gameboard[space.x_coord - 1].spaces_array[space.y_coord + 1]
          end
          if space.x_coord + 1 <= @column_count - 1
            adjacent_spaces << @gameboard[space.x_coord + 1].spaces_array[space.y_coord + 1]
          end
        end
      space.adjacent_mines = adjacent_spaces.count{ |space| space.mine == true }
      end
    end
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    clear = true
    # binding.pry if @pause == true
    if @gameboard[row].spaces_array[col].state == :clicked
      clear = true
    else
      clear = false
    end
    clear
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    clear = false
    if @gameboard[row].spaces_array[col].state == :unclicked
      @gameboard[row].spaces_array[col].state = :clicked
      clear = true
      @pause = true
    end
    clear
    self.check_adjacent_mines(row, col)
  end

  def check_adjacent_mines(row, col) ## work on
      # above
      if row - 1 >= 0
        if @gameboard[row - 1].spaces_array[col].mine == false
          @gameboard[row - 1].spaces_array[col].state = :clicked
        end
        if col - 1 >= 0
          if @gameboard[row - 1].spaces_array[col - 1].mine == false
            @gameboard[row - 1].spaces_array[col - 1].state = :clicked
          end
        end
        if col + 1 <= @column_count - 1
          if @gameboard[row - 1].spaces_array[col + 1].mine == false
            @gameboard[row - 1].spaces_array[col + 1].state = :clicked
          end
        end
      end
      # same row
      if col - 1 >= 0
        if @gameboard[row].spaces_array[col - 1].mine == false
          @gameboard[row].spaces_array[col - 1].state = :clicked
        end
      end
      if col + 1 <= @column_count - 1
        if @gameboard[row].spaces_array[col + 1].mine == false
          @gameboard[row].spaces_array[col + 1].state = :clicked
        end
      end
      # below
      if row + 1 <= @row_count - 1
        if @gameboard[row + 1].spaces_array[col].mine == false
          @gameboard[row + 1].spaces_array[col].state = :clicked
        end
        if col - 1 >= 0
          if @gameboard[row + 1].spaces_array[col - 1].mine == false
            @gameboard[row + 1].spaces_array[col - 1].state = :clicked
          end
        end
        if col + 1 <= @column_count - 1
          if @gameboard[row + 1].spaces_array[col + 1].mine == false
            @gameboard[row + 1].spaces_array[col + 1].state = :clicked
          end
        end
      end
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    mine_blown_up = false
    if mine_blown_up == false
      @gameboard.each do |row|
        row.spaces_array.each do |space|
          if space.mine == true && space.state == :clicked
            mine_blown_up = true
          end
        end
      end
    end
    mine_blown_up
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    all_clear = true
    if all_clear == true
      @gameboard.each do |row|
        row.spaces_array.each do |space|
          if space.mine == false && space.state == :clicked
            all_clear = true
          else
            all_clear = false
          end
        end
      end
    end
    all_clear
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    @gameboard[row].spaces_array[col].adjacent_mines
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col) ## this works b/c spot will turn red
    is_mine = false
    if @gameboard[row].spaces_array[col].mine == true
      is_mine = true
    else
      is_mine = false
    end
    is_mine
  end
end
