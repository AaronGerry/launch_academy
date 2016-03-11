# Might make sense to pull gameboard into minefield...

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
    clear = true
    if @current_move == :clicked
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
    false
    # clear = false
    # @current_move = @gameboard.user_move(row, col)
    # if @current_move.state == :clicked
    #   clear = true
    # end
    # clear
    # self.check_adjacent_mines(@current_move)
  end

  def check_adjacent_mines(current_move)
      # above
      if current_move.y_coord - 1 >= 0
        if @gameboard.grid[current_move.x_coord].spaces_array[current_move.y_coord - 1].mine == false
          @gameboard.grid[current_move.x_coord].spaces_array[current_move.y_coord - 1].state = :clicked
        end
        if current_move.x_coord - 1 >= 0
          if @gameboard.grid[current_move.y_coord - 1].spaces_array[current_move.x_coord - 1].mine == false

            @gameboard.grid[current_move.x_coord - 1].spaces_array[current_move.y_coord - 1].state = :clicked
          end
        end
        if current_move.x_coord + 1 <= @column_count - 1
          if @gameboard.grid[current_move.y_coord - 1].spaces_array[current_move.x_coord + 1].mine == false

            @gameboard.grid[current_move.y_coord - 1].spaces_array[current_move.x_coord + 1].state = :clicked
          end
        end
      end
      # same row
      if current_move.x_coord - 1 >= 0
        if @gameboard.grid[current_move.y_coord].spaces_array[current_move.x_coord - 1].mine == false
          @gameboard.grid[current_move.y_coord].spaces_array[current_move.x_coord - 1].state = :clicked
        end
      end
      if current_move.x_coord + 1 <= @column_count - 1
        if @gameboard.grid[current_move.y_coord].spaces_array[current_move.x_coord + 1].mine == false
          @gameboard.grid[current_move.y_coord].spaces_array[current_move.x_coord + 1].state = :clicked
        end
      end
      # below
      if current_move.y_coord + 1 <= @row_count - 1
        @gameboard.grid[current_move.y_coord + 1].spaces_array[current_move.x_coord].mine == false
          @gameboard.grid[current_move.y_coord + 1].spaces_array[current_move.x_coord].state = :clicked
        if current_move.x_coord - 1 >= 0
          @gameboard.grid[current_move.y_coord + 1].spaces_array[current_move.x_coord - 1].mine == false

            @gameboard.grid[current_move.y_coord + 1].spaces_array[current_move.x_coord - 1].state = :clicked
        end
        if current_move.x_coord + 1 <= @column_count - 1
          @gameboard.grid[current_move.y_coord + 1].spaces_array[current_move.x_coord + 1].mine == false

            @gameboard.grid[current_move.y_coord + 1].spaces_array[current_move.x_coord + 1].state = :clicked
        end
      end
  end

  # Check if any cells have been uncovered that also contained a mine. This is
  # the condition used to see if the player has lost the game.
  def any_mines_detonated?
    if @current_move.mine == true
      true
    else
      false
    end
  end

  # Check if all cells that don't have mines have been uncovered. This is the
  # condition used to see if the player has won the game.
  def all_cells_cleared?
    clear = true
    while clear == true
      @gameboard.grid.each do |row|
        row.spaces_array.each do |space|
          if space.mine == false && space.state == :clicked
            clear = true
          else
            clear = false
          end
        end
      end
    end
    clear
  end

  # Returns the number of mines that are surrounding this cell (maximum of 8).
  def adjacent_mines(row, col)
    binding.pry

    # have it read adjacent_mines from gameboard_space object or check manually
    @current_move.adjacent_mines
  end

  # Returns true if the given cell contains a mine, false otherwise.
  def contains_mine?(row, col)
    mine = false
    if @current_move.mine == true
      mine = true
    else
      mine = false
    end
    mine
  end
end
