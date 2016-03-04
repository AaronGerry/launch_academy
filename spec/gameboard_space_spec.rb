require 'spec_helper'

describe GameboardSpace do
  let(:gameboard) { Gameboard.new(20, 20, 50) }
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


end
