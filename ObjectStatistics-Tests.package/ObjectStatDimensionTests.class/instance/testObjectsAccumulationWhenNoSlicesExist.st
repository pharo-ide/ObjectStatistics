tests
testObjectsAccumulationWhenNoSlicesExist

	| dimension overallStat slice |
	overallStat := Mock new.
	dimension := ObjectStatDimension by: [ :each |  #sliceCoordinate ].
	dimension overallStatistics: overallStat.
	
	dimension accumulate: #object.
	
	slice := dimension sliceFor: #sliceCoordinate.
	slice should beInstanceOf: ObjectStatSlice.
	slice coordinate should be: #sliceCoordinate.
	slice statistics should beReturnedFrom: [overallStat newForDimension: dimension].
	slice statistics should receive accumulate: #object