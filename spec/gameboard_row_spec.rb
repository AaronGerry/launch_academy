describe GameboardRow do
  let(:gameboard) { Gameboard.new(5, 5, 5) }
  let(:row) { GameboardRow.new }

  it 'generates an array capable of holding items' do

    expect(row.spaces_array.class).to eq(Array)
  end

  it 'it contains a list of items' do
    gameboard.generate_grid

    expect(gameboard.grid[0].spaces_array.size).to eq(5)
  end

end
