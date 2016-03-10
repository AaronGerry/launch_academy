require 'spec_helper'

describe GameboardSpace do
  let(:gameboard) { Gameboard.new(2, 2, 4) }
  let(:generated_board) { gameboard.generate }
  let(:space) { GameboardSpace.new(true) }
  let(:not_mine_space) { GameboardSpace.new(false) }

  it 'has a clicked/ unclicked state' do

    expect(space.state).to eq(:unclicked)
  end

  it 'can be a mine' do

    expect(space.mine).to be true
  end

  it 'can not be a mine' do

    expect(not_mine_space.mine).to be false
  end

  it 'has a count for adjacent mines' do

    expect(space.adjacent_mines).to eq(2)
  end

  it 'has an x-coordinate' do

    expect(space.x_coord).to be nil
  end

  it 'has an y-coordinate' do

    expect(space.y_coord).to be nil
  end
end
