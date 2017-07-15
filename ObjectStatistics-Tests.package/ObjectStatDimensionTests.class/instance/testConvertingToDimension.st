tests
testConvertingToDimension

	| dimension |
	dimension := ObjectStatDimension new.
	
	dimension where asObjectStatDimension should be: dimension