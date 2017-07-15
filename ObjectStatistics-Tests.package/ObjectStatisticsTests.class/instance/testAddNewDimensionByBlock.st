tests
testAddNewDimensionByBlock

	| stat actual block |
	block := [:o | o class].
	stat := ObjectStatistics new.
	stat addDimension: block.
	
	actual := stat dimensions first.
	actual should beInstanceOf: ObjectStatDimension.
	actual where coordinatesBlock should be: block