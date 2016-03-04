class GameboardSpace
  attr_reader :state, :mine

  def initialize(is_a_mine)
    @state = :unclicked
    @mine = is_a_mine
  end
end
