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

  # could make sense to store adjacent_mines in the instance of each space
  # then you would run through and mark these after creating the board
  # as I'm doing it now, I'm going to check each space on a move by move basis


  # think it makes sense to store x, y coordinates in each space
  # this way, when I go through each space to search for adjacent mines, I can use the coordinates to search for neighbors
end
