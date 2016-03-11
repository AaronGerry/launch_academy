class GameboardSpace
  attr_reader :mine
  attr_accessor :state, :adjacent_mines, :x_coord, :y_coord

  def initialize(is_a_mine)
    @state = :unclicked
    @mine = is_a_mine
    @adjacent_mines = 0
    @x_coord = nil
    @y_coord = nil
  end
end
