tests
testCopyForSubDimension

	| dimension copy |
	dimension := ObjectStatDimension named: 'test dim'.
	dimension slices: #currentSlices.
	
	copy := dimension copyForSubDimension.
	
	copy should beInstanceOf: ObjectStatDimension.
	copy name should equal: 'test dim'.
	copy slices should not be: dimension slices.
	copy slices should beInstanceOf: Dictionary 