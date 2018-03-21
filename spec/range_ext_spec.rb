require 'range_ext'
describe Range do
  describe '#overlaps?' do
  	it 'returns true if two ranges overlap' do
  	  expect((1..3).overlaps?(2..4)).to eq(true)
  	  expect((1..5).overlaps?(2..3)).to eq(true)
  	  expect((2..3).overlaps?(1..5)).to eq(true)
  	  expect((2..4).overlaps?(1..3)).to eq(true)
  	  expect((1..3).overlaps?(3..5)).to eq(true)
  	end
  	it 'returns false if the ranges do not overlap' do
  	  expect((1..3).overlaps?(4..6)).to eq(false)
  	  expect((4..6).overlaps?(1..3)).to eq(false)
  	end
  end
end