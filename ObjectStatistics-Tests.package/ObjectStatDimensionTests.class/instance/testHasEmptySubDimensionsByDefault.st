tests
testHasEmptySubDimensionsByDefault

	| dimension |
	dimension := ObjectStatDimension new.
	
	dimension where subDimensions should be isEmpty