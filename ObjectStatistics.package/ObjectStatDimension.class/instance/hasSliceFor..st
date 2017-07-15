testing
hasSliceFor: anObject

	| coordinateObject |
	coordinateObject := self coordinateFor: anObject.
	
	^slices includesKey: coordinateObject