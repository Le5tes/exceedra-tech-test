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



## initial approach ##

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