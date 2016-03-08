class Gameboard
  attr_reader :rows, :columns, :grid

  def initialize(row_count, column_count, mine_count)
    @rows = row_count
    @columns = column_count
    @mine_count = mine_count
    @grid = nil
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
    all_spaces.shuffle!

    @grid.each do |row|
      row.spaces_array.map! { |space| space = all_spaces.pop }
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

private
  attr_reader :mine_count

end
