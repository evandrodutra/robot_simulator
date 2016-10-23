require 'spec_helper'
require 'matrix'

describe Table do
  it 'must start positon from zero' do
    table = Table.new(5, 5)

    expect(table.x).to eq(4)
    expect(table.y).to eq(4)
    expect(table.place_exist?(0, 0)).to be_truthy
    expect(table.place_exist?(4, 4)).to be_truthy
    expect(table.place_exist?(5, 5)).to be_falsey
  end

  it 'must validate the desired coordinates' do
    table = Table.new(5, 5)

    Matrix.build(5, 5).to_a.each do |point|
      expect(table.place_exist?(point[0], point[1])).to be_truthy
    end

    [[nil, nil], [5, 5], [-1, -1]].each do |point|
      expect(table.place_exist?(point[0], point[1])).to be_falsey
    end
  end
end
