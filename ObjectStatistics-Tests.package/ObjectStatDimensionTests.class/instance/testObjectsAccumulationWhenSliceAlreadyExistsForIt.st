tests
testObjectsAccumulationWhenSliceAlreadyExistsForIt

	| dimension slice |
	slice := Mock new.
	dimension := ObjectStatDimension by: [ :each | #sliceCoordinate ].
	
	dimension slices at: #sliceCoordinate put: slice.
	
	dimension accumulate: #object.
	
	slice should receive accumulate: #object