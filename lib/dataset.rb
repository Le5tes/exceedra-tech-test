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
		if dates[0].min < dates[1].min
			dates[0] = (dates[0].min)..(day_before(dates[1].min))
		elsif dates[0].min > dates[1].min
			dates[0] = (day_after(dates[1].max))..(dates[0].max)
		end
		dates
	end

	def adjust_overlapping_dates
		groups = group
		groups.each {|group|
			get_pairs_with_overlapping_dates(group).each{ |pair|
				i = @data.find_index(pair[0])
				  range = date_adjust(pair.map{|row|
						daterange(row)
					})[0]
					pair[0][:Valid_From]  = range.min if pair[0][:Valid_From] < range.min
					pair[0][:Valid_To] = range.max if pair[0][:Valid_To] > range.max
				@data[i] = pair[0]
			}
		}
		return @data
	end

	private

	def get_similar(compare)
		@data.select {|row|
				[row[:Product], row[:Customer], row[:Measure]] == [compare[:Product], compare[:Customer], compare[:Measure]]
			}
	end

	def day_before(date)
		begin
			(Date.parse(date.to_s) - 1).to_s.gsub('-','').to_i
		rescue
			date - 1
		end
	end

	def day_after(date)
		begin
			(Date.parse(date.to_s) + 1).to_s.gsub('-','').to_i
		rescue
			date + 1
		end
	end
end
