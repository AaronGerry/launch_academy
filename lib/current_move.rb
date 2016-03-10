class CurrentMove
  attr_reader :row, :column
  attr_accessor :adjacent_mines

  def initialize(row, column)
    @row = row
    @column = column
    @adjacent_mines = 0
  end
end
