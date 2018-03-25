require 'date'
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

	def date_adjust(dates)
		dates = dates.map {|date_range| (Date.parse(date_range.min.to_s))..(Date.parse(date_range.max.to_s))}
		dates[0] = (dates[0].min)..((dates[1].min) -1)
		dates = dates.map {|date_range| (date_range.min.to_s.gsub('-', '').to_i)..(date_range.max.to_s.gsub('-', '').to_i)}
	end

	private

	def get_similar(compare)
		@data.select {|row|
				[row[:Product], row[:Customer], row[:Measure]] == [compare[:Product], compare[:Customer], compare[:Measure]]
			}
	end

end
