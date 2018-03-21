class Dataset

	def initialize(data)
		@data = data
	end

	def group()
		ids = []
		groups = []
		first = @data.first
		while first
			group = get_similar(first)
			group.each {|row| ids.push(row[:id])}
			groups.push(group)
			first = @data.reject {|row| ids.include?(row[:id]) }.first
		end
		return groups
	end

	def get_pairs_with_overlapping_dates(group)
		group.combination(2).to_a
							.select {|pair|
							  daterange(pair[0]).overlaps?(daterange(pair[1]))
							}
	end

	def daterange(row)
		row[:Valid_From]..row[:Valid_To]
	end

	private

	def get_similar(compare)
		@data.select {|row|
				[row[:Product], row[:Customer], row[:Measure]] == [compare[:Product], compare[:Customer], compare[:Measure]]
			}
	end

end