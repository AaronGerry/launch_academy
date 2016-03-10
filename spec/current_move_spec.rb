require 'spec_helper'

describe CurrentMove do

  it 'has a row and column value' do
    current_move = CurrentMove.new(1, 1)

    expect(current_move.row).to eq(1)
    expect(current_move.column).to eq(1)
  end

end
