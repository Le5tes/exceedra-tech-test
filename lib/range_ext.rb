class Range
  def overlaps?(range)
    return (self.cover? range.min) || (self.cover? range.max) || (range.cover? self.min) || (range.cover? self.max) 
  end
end