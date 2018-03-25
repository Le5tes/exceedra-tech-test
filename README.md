# exceedra-tech-test

## instructions ##

1.	Complete the table above.

2.	Create a process which solves parts A and B below; and then answer part C. Document your work using either a flowchart, pseudo-code, a written sequence of steps, or a programming language you are familiar with. The table below is example data, but your solution should be generic and hence applicable to any data supplied in this format.

A.	Identify which pairs of rows have identical Products, Customers and Measures, and overlapping date ranges; e.g., as per rows 1 and 2.

B.	Of the rows identified in part A, update the rows to make the date ranges not overlap.

C.	Document any assumptions or decisions you needed to make for your solution.

Row ID	Product	Customer	Measure	Value	Valid From Day	Valid To Day
1	Widgets	Tesco	Gross Sales Price	1	20130101	20130401
2	Widgets	Tesco	Gross Sales Price	1.5	20130301	20131231
3	Widgets	Tesco	Gross Sales Price	2	20130401	20150101
4	Widgets	Tesco	Distribution Cost	5	20130101	20130401
5	Widgets	Tesco	Distribution Cost	6	20130301	20140401
6	Widgets	Tesco	Distribution Cost	7	20131231	20150101
7	Widgets	Asda	Gross Sales Price	100	00000000	99999999
8	Widgets	Asda	Gross Sales Price	200	20131231	20150101
9	Widgets	Asda	Distribution Cost	2	20130301	20131231
10	Widgets	Asda	Distribution Cost	3	20140401	20150101



## approach ##

### find rows that have the same product customer and measure:

1. Get first row in table
2. Select from table rows where product, customer and measure are the same as the above
	- store these rows somewhere
	- keep track of the ids
3. select first row from table, where id is not in the above list
4. while there are still rows, go to 2.

### use the created sets of data to compare dates and generate pairs of rows

1. Get all combinations of 2 rows within a group
2. Select those where the dates overlap

### for each pair of rows...

- at this point I need to make a decision as to which of the pair takes precedence over dates.
-- i.e. if the first is from 20130101 to 20130401 and the second is 20130301 to 20130501 does it become 20130101-20130228 and 20130301-20140501 or 20130101-20130401 and 20130402 to 20130501?
-- in this case it seems to make more sense the first way as each service is offered for a period of months, also it would make sense for later entries to overwrite earlier ones. I will follow this pattern for the time being.
-- for rows 7 and 8 it might make sense to turn this into three rows- i.e. [value: 100 from: 00000000 to: 20131230, value: 200 from: 20131231 to: 20150101, value: 100 from: 20150102 to: 99999999], but this seems like too great a change to the table layout for now
-- another option would be to get the average of the overlapping values, but I can't imagine that being meaningful. Also that wouldn't work where one range completely covers another as in rows 7 and 8.
-- all of this only makes sense if we assume the dates were intended to be formatted yyyymmdd, which they all seem to fit to except for row 7.

1. adjust the dates of the first row
2. replace the values in the table with the new values
