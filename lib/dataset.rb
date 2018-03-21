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

	private

	def get_similar(compare)
		@data.select {|row|
				[row[:Product], row[:Customer], row[:Measure]] == [compare[:Product], compare[:Customer], compare[:Measure]]
			}
	end
end