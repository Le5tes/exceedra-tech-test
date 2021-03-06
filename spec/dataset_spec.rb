require 'dataset'

describe Dataset do
  data = [
{id: 1,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 1,   Valid_From: 20130101, Valid_To: 20130401},
{id: 2,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 1.5, Valid_From: 20130301, Valid_To: 20131231},
{id: 3,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 2,   Valid_From: 20130401, Valid_To: 20150101},
{id: 4,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 5,   Valid_From: 20130101, Valid_To: 20130401},
{id: 5,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 6,   Valid_From: 20130301, Valid_To: 20140401},
{id: 6,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 7,   Valid_From: 20131231, Valid_To: 20150101},
{id: 7,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Gross Sales Price', Value: 100, Valid_From: 00000000, Valid_To: 99999999},
{id: 8,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Gross Sales Price', Value: 200, Valid_From: 20131231, Valid_To: 20150101},
{id: 9,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Distribution Cost', Value: 2,   Valid_From: 20130301, Valid_To: 20131231},
{id: 10, Product: 'Widgets', Customer: 'Asda',  Measure: 'Distribution Cost', Value: 3,   Valid_From: 20140401, Valid_To: 20150101}
  ]

  subject {described_class.new(data)}

  describe '#group' do
    it 'returns groups of data from the original set where the product, customer and measure are identical' do
    	expect(subject.group).to eq([
    		[
    			{id: 1,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 1,   Valid_From: 20130101, Valid_To: 20130401},
				{id: 2,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 1.5, Valid_From: 20130301, Valid_To: 20131231},
				{id: 3,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 2,   Valid_From: 20130401, Valid_To: 20150101}
			],
	    	[
	    		{id: 4,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 5,   Valid_From: 20130101, Valid_To: 20130401},
				{id: 5,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 6,   Valid_From: 20130301, Valid_To: 20140401},
				{id: 6,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 7,   Valid_From: 20131231, Valid_To: 20150101}
			],
			[
				{id: 7,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Gross Sales Price', Value: 100, Valid_From: 00000000, Valid_To: 99999999},
				{id: 8,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Gross Sales Price', Value: 200, Valid_From: 20131231, Valid_To: 20150101}
			],
			[
				{id: 9,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Distribution Cost', Value: 2,   Valid_From: 20130301, Valid_To: 20131231},
				{id: 10, Product: 'Widgets', Customer: 'Asda',  Measure: 'Distribution Cost', Value: 3,   Valid_From: 20140401, Valid_To: 20150101}
			]
    	])
    end
  end

  describe '#get_pairs_with_overlapping_dates'do
    it 'returns an array of pairs of rows where the dates overlap, given a group' do
      data2 = [
    			{id: 4,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 5,   Valid_From: 20130101, Valid_To: 20130401},
				{id: 5,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 6,   Valid_From: 20130301, Valid_To: 20140401},
				{id: 6,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 7,   Valid_From: 20131231, Valid_To: 20150101}
			]
      expect(subject.get_pairs_with_overlapping_dates(data2)).to eq([
      		[
      			{id: 4,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 5,   Valid_From: 20130101, Valid_To: 20130401},
				{id: 5,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 6,   Valid_From: 20130301, Valid_To: 20140401}
      		],
      		[
      			{id: 5,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 6,   Valid_From: 20130301, Valid_To: 20140401},
				{id: 6,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 7,   Valid_From: 20131231, Valid_To: 20150101}
      		]
      	])
    end
  end

  # describe '#daterange(row)' do
  # 	it 'returns a the Valid_To and Valid_From values of a row as a range' do
  # 	  expect(subject.daterange(
  # 	  	{id: 4,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 5,   Valid_From: 20130101, Valid_To: 20130401}
  # 	  	))
  # 	  .to eq(20130101..20130401)
  # 	end
  # end
  #
  # describe '#date_adjust' do
  #   it 'adjusts the first date range of a pair so that it no longer overlaps the second' do
  #     expect(subject.date_adjust([(20130101..20140101),(20130601..20140303)])).to eq([(20130101..20130531),(20130601..20140303)])
  #     expect(subject.date_adjust([20130601..20140303,20130101..20140101])).to eq([20140102..20140303,20130101..20140101])
  #     expect(subject.date_adjust([00000000..20140101,20130401..20140202])).to eq([00000000..20130331,20130401..20140202])
  #   end
  # end

  describe '#adjust_overlapping_dates' do
    it 'identifies pairs of rows with identical products, customers and measures, and overlapping date ranges and adjusts the dates so they no longer overlap, returning the data' do
      expect(subject.adjust_overlapping_dates).to eq([
        {id: 1,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 1,   Valid_From: 20130101, Valid_To: 20130228},
        {id: 2,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 1.5, Valid_From: 20130301, Valid_To: 20130331},
        {id: 3,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Gross Sales Price', Value: 2,   Valid_From: 20130401, Valid_To: 20150101},
        {id: 4,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 5,   Valid_From: 20130101, Valid_To: 20130228},
        {id: 5,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 6,   Valid_From: 20130301, Valid_To: 20131230},
        {id: 6,  Product: 'Widgets', Customer: 'Tesco', Measure: 'Distribution Cost', Value: 7,   Valid_From: 20131231, Valid_To: 20150101},
        {id: 7,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Gross Sales Price', Value: 100, Valid_From: 00000000, Valid_To: 20131230},
        {id: 8,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Gross Sales Price', Value: 200, Valid_From: 20131231, Valid_To: 20150101},
        {id: 9,  Product: 'Widgets', Customer: 'Asda',  Measure: 'Distribution Cost', Value: 2,   Valid_From: 20130301, Valid_To: 20131231},
        {id: 10, Product: 'Widgets', Customer: 'Asda',  Measure: 'Distribution Cost', Value: 3,   Valid_From: 20140401, Valid_To: 20150101}
      ])
    end
  end
end
