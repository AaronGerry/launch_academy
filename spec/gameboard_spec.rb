require 'spec_helper'

# should take information in from minefield? >> Same info


describe Gameboard do
  let(:gameboard) { Gameboard.new(20, 20, 50) }
  let(:generated_board) { gameboard.generate }

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

    expect(gameboard.grid[0].spaces_array[0]).to_not be_nil
  end

  it 'makes some game spaces mines' do

    expect(gameboard.place_mines).to include(mine)
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
