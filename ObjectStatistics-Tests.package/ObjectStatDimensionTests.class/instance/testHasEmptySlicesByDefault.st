tests
testHasEmptySlicesByDefault

	| dimension |
	dimension := ObjectStatDimension new.
	
	dimension where slices should be isEmpty