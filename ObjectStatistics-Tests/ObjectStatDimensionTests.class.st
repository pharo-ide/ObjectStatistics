Class {
	#name : #ObjectStatDimensionTests,
	#superclass : #TestCase,
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatDimensionTests >> testCheckThatMetricIsIgnored [

	| dimension |
	dimension := ObjectStatDimension new.
	dimension ignoreMetrics: #('metric1Name' 'metric2Name').
	
	dimension should be isIgnoreMetric: (ObjectStatMetric named: 'metric1Name').
	dimension should be isIgnoreMetric: (ObjectStatMetric named: 'metric2Name').
	
	dimension should not be isIgnoreMetric: (ObjectStatMetric named: 'someOtherMetric')
]

{ #category : #tests }
ObjectStatDimensionTests >> testConvertingToDimension [

	| dimension |
	dimension := ObjectStatDimension new.
	
	dimension where asObjectStatDimension should be: dimension
]

{ #category : #tests }
ObjectStatDimensionTests >> testCopyForSubDimension [

	| dimension copy |
	dimension := ObjectStatDimension named: 'test dim'.
	dimension slices: #currentSlices.
	
	copy := dimension copyForSubDimension.
	
	copy should beInstanceOf: ObjectStatDimension.
	copy name should equal: 'test dim'.
	copy slices should not be: dimension slices.
	copy slices should beInstanceOf: Dictionary 
]

{ #category : #tests }
ObjectStatDimensionTests >> testGettingSortedSlices [

	| dimension actual stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'strings'.
	dimension := [:o | o size] asObjectStatDimension.
	dimension overallStatistics: stat.
	
	dimension accumulateAll: #('asd' 'qwe' 'a' 'b' 'c' '1234').
	
	actual := dimension sortedSlices.
	
	actual should haveSize: 3.
	actual where first coordinate should be: 1.
	actual where second coordinate should be: 3.
	actual where last coordinate should be: 4.
]

{ #category : #tests }
ObjectStatDimensionTests >> testHasAnyObjectsSpecByDefault [

	| dimension |
	dimension := ObjectStatDimension new.
	
	(dimension objectsSpec == Any) should be: true
]

{ #category : #tests }
ObjectStatDimensionTests >> testHasEmptySlicesByDefault [

	| dimension |
	dimension := ObjectStatDimension new.
	
	dimension where slices should be isEmpty
]

{ #category : #tests }
ObjectStatDimensionTests >> testHasEmptySubDimensionsByDefault [

	| dimension |
	dimension := ObjectStatDimension new.
	
	dimension where subDimensions should be isEmpty
]

{ #category : #tests }
ObjectStatDimensionTests >> testObjectsAccumulationShouldSkipObjectsWhichNotSatisfiedSpec [

	| dimension slice |
	slice := Mock new.
	dimension := ObjectStatDimension by: [ :each | #sliceCoordinate ].
	dimension objectsSpec: [ :o | o ~= #object ].
	
	dimension slices at: #sliceCoordinate put: slice.
	
	dimension accumulate: #object.
	
	slice should not receive accumulate: #object
]

{ #category : #tests }
ObjectStatDimensionTests >> testObjectsAccumulationWhenNoSlicesExist [

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
]

{ #category : #tests }
ObjectStatDimensionTests >> testObjectsAccumulationWhenSliceAlreadyExistsForIt [

	| dimension slice |
	slice := Mock new.
	dimension := ObjectStatDimension by: [ :each | #sliceCoordinate ].
	
	dimension slices at: #sliceCoordinate put: slice.
	
	dimension accumulate: #object.
	
	slice should receive accumulate: #object
]

{ #category : #tests }
ObjectStatDimensionTests >> testPreparingStatistics [

	| dimension |
	[:subDimension1 :subDimension2 :stat |
		dimension := ObjectStatDimension new.
		dimension subDimensions: { subDimension1. subDimension2 }.
		subDimension1 stub copyForSubDimension willReturn: #newDim1.
		subDimension2 stub copyForSubDimension willReturn: #newDim2.
		
		dimension prepareStatistics: stat.
		
		stat should receive addDimension: #newDim1.
		stat should receive addDimension: #newDim2.	
	 ] runWithMocks 
]
