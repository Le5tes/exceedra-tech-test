class Dataset

	def initialize(data)
		@data = data
	end

	def group()
		ids = []
		groups = []
		first = @data[0]
		while first
			group = @data.select {|row|
				[row[:Product], row[:Customer], row[:Measure]] == [first[:Product], first[:Customer], first[:Measure]]
			}
			group.each {|row| ids.push(row[:id])}
			groups.push(group)
			first = @data.select {|row| !ids.include?(row[:id]) }.first
		end
		return groups
	end
end