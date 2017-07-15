tests
testHasEmptyDimensionsByDefault

	| stat |
	stat := ObjectStatistics new.
	
	stat where dimensions should be isEmpty