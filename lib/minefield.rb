# now that we have the field of play with spaces, can start implimenting user interaction

require_relative 'gameboard'
require 'pry'

class Minefield
  attr_reader :row_count, :column_count, :current_move

  def initialize(row_count, column_count, mine_count)
    @row_count = row_count
    @column_count = column_count
    @mine_count = mine_count
    self.create_gameboard
  end

  def create_gameboard
    @gameboard = Gameboard.new(@row_count, @column_count, @mine_count)
    @gameboard.set_gameboard
  end

  # Return true if the cell been uncovered, false otherwise.
  def cell_cleared?(row, col)
    # binding.pry
    if @current_move == :clicked
      true
    else
      false
    end
    #coordinates for click come in
  end

  # Uncover the given cell. If there are no adjacent mines to this cell
  # it should also clear any adjacent cells as well. This is the action
  # when the player clicks on the cell.
  def clear(row, col)
    # 1) current_move = CurrentMove.new()
      # row, col, adjacent_mines
    # 2) look up game space object, inside are state, mine, and adjacent mine info

    @current_move = @gameboard.user_move(row, col)
    # clear will only check the clicked spot


      # top left was 0, 0
      binding.pry


      # logic for checking adjacent spaces >> abstract out into method or module
      # options:
      # if space clicked?
      # if space mine?
      # if space.exist? # if true
              # if space.nil? >> need way to ignore spaces that don't exist/ fall outside the board, easier than writing test cases for all spots along edges >> this can be a separate method. ie., check if space.exist?
        # if @grid[row - 1].spaces_array[col -1].state == :unclicked
        #   && @grid[row - 1].spaces_array[col -1].mine == false
        #   @grid[row - 1].spaces_array[col -1].state == :clicked


        # x - 1, y - 1 (top left)
        # x, y - 1 (top middle)
        # x + 1, y -1 (top right)
        # x - 1, y (middle left)
        # x + 1, y (middle right)
        # x - 1, y + 1 (bottom left)
        # x, y + 1 (bottom middle)
        # x + 1, y + 1 (bottom right)

    # elsif col == 0 || col == column_count - 1
    # check remaining spaces

    # end
    # this turned all spaces light gray
    # doing this because no adjacent mines?
  end

  def exist?(row, col)
    # if less than 0 for x or greater than row_count
    # if less than 0 for y or greater than column_count
    if row == 0 # top
      # any row - 1 does not exist
      if row - 1
        false
      elsif row + 1
        true
      end
    elsif row == row_count
      if row - 1
        true
      elsif row + 1
        false
      end
    end

      # dealing with top and bottom rows
  end

  # def adjacent_spaces

  # 1) Check adjacent space
  # 2) check if space exists
  # 3) check if unclicked and not a mine...

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

      # x - 1, y - 1 (top left)
      # x, y - 1 (top middle)
      # x + 1, y -1 (top right)
      # x - 1, y (middle left)
      # x + 1, y (middle right)
      # x - 1, y + 1 (bottom left)
      # x, y + 1 (bottom middle)
      # x + 1, y + 1 (bottom right)
  # end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    false
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    false
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)

    0
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    false
  end
end
