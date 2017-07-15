tests
testObjectsAccumulationShouldSkipObjectsWhichNotSatisfiedSpec

	| dimension slice |
	slice := Mock new.
	dimension := ObjectStatDimension by: [ :each | #sliceCoordinate ].
	dimension objectsSpec: [ :o | o ~= #object ].
	
	dimension slices at: #sliceCoordinate put: slice.
	
	dimension accumulate: #object.
	
	slice should not receive accumulate: #object