accessing
sliceFor: anObject

	| coordinateObject |
	coordinateObject := self coordinateFor: anObject.
	
	^slices at: coordinateObject ifAbsentPut: [ 
		ObjectStatSlice at: coordinateObject statistics: (overallStatistics newForDimension: self)  ]