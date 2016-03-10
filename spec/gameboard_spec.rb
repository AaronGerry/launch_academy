require 'spec_helper'

# should take information in from minefield? >> Same info

describe Gameboard do
  let(:gameboard) { Gameboard.new(20, 20, 10) }
  let(:generated_board) { gameboard.generate_grid }

  it 'has columns' do

    expect(gameboard.columns).to eq(20)
    # to require columns and rows, but make the number private? >> not needed publicly
  end

  it 'has rows' do

    expect(gameboard.rows).to eq(20)
  end

  it '#generates a grid made up of rows' do
    generated_board

    expect(gameboard.grid.size).to eq(20)
  end

  it 'has rows made up of individual game spaces' do
    generated_board

    expect(gameboard.grid[0].spaces_array[0]).to eq nil
  end

  it 'makes some game spaces mines' do

    expect(gameboard.create_mines[0].mine).to be true
  end

  it 'makes game spaces that are not mines' do

    expect(gameboard.create_blank_spaces[0].mine).to be false
  end

  it 'places mines onto the board' do
    new_gameboard = Gameboard.new(5, 5, 25)
    new_gameboard.generate_grid
    new_gameboard.place_pieces

    expect(new_gameboard.grid[0].spaces_array[0].mine).to be true
  end

  it 'changes the state of a game space if it has been clicked' do
    new_gameboard = Gameboard.new(3, 3, 4)
    new_gameboard.generate_grid
    new_gameboard.place_pieces
    row = 0
    col = 2

    expect(new_gameboard.user_move(row, col).state).to eq(:clicked)
  end

  it 'assigns an x-coordinate to a gamespace' do
    new_gameboard = Gameboard.new(3, 3, 4)
    new_gameboard.generate_grid
    new_gameboard.place_pieces

    expect(new_gameboard.grid[0].spaces_array[0].x_coord).to eq(0)
  end

  it 'assigns an y-coordinate to a gamespace' do
    new_gameboard = Gameboard.new(3, 3, 4)
    new_gameboard.generate_grid
    new_gameboard.place_pieces

    expect(new_gameboard.grid[0].spaces_array[1].y_coord).to eq(1)
  end

  it 'counts the number of adjacent mines for each space' do
    new_gameboard = Gameboard.new(2, 2, 3)
    new_gameboard.generate_grid
    new_gameboard.place_pieces
    new_gameboard.count_adjacent_mines
    row = 0
    col = 0

    expect(new_gameboard.user_move(row, col).adjacent_mines).to eq(2)
  end


# this probably falls outside the purview of gameboard... More pertinent to game space itself
  # it 'has some spaces that contain mines' do
  #   generated_board
  #
  #   expect(gameboard.grid[0].spaces_array[0].mine).to be true
  # end

# this is a bit misleading of a test
  # it '#generates a board of individual game spaces' do
  #
  #   expect(gameboard.generate.class).to be(Array)
  #   expect(gameboard.generate).not_to be_empty
  # end



  # Gameboard: Class
  # - Made up of spots
  # - Row.each do, column.each do to generate board
  # - location << Spot.new
  # - randomly assigns mines

end
