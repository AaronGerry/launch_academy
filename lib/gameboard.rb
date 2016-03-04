class Gameboard
  attr_reader :rows, :columns, :grid

  def initialize(row_count, column_count, mine_count)
    @rows = row_count
    @columns = column_count
    @mine_count = mine_count
    @grid = nil
  end

  def generate
    is_a_mine = false
    @rows.times do |row|
      row = GameboardRow.new
      @columns.times do |col|
        row.spaces_array << GameboardSpace.new(is_a_mine)
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

  # need a mine_count_counter to keep track of all the mine pieces
  # probably want it to be a separate method that goes through each space after they are all made

  def place_mines
    # need a way to randomly assign mines
    # need to cycle through all spaces to assign mines
    #use @rows and @columns to determine total number of spaces
  end

private
  attr_reader :mine_count

end
