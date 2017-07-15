tests
testAddNewDimensionWithName

	| dimension stat actual result |
	dimension := Mock new.
	stat := ObjectStatistics new.
	result := stat dimension: dimension named: 'test dimension'.
	
	actual := stat dimensions first.
	actual should receive name: 'test dimension'.
	result should be: actual
	