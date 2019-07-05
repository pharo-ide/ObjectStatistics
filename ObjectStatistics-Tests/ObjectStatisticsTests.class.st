Class {
	#name : #ObjectStatisticsTests,
	#superclass : #TestCase,
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatisticsTests >> testAccumulationAllObjects [

	| stat |
	[:metric1 :metric2 |
		stat := ObjectStatistics new.
		stat metrics: { metric1. metric2 }.
	
		stat accumulateAll: #(#object1 #object2).

		[ metric1 accumulate: #object1.
		metric2 accumulate: #object1.
		metric1 accumulate: #object2.
		metric2 accumulate: #object2 ] should beDone
	] runWithMocks 
]

{ #category : #tests }
ObjectStatisticsTests >> testAccumulationObjects [

	| stat |
	[:metric1 :metric2 :dimension1 :dimension2 |
		stat := ObjectStatistics new.
		stat metrics: { metric1. metric2 }.
		stat dimensions: { dimension1. dimension2 }.
	
		stat accumulate: #object.

		[ metric1 accumulate: #object.
		metric2 accumulate: #object.
		dimension1 accumulate: #object.
		dimension2 accumulate: #object ] should beDone
	] runWithMocks 
]

{ #category : #tests }
ObjectStatisticsTests >> testAddNewDimension [

	| dimension actual stat |
	dimension := Mock new.
	stat := ObjectStatistics new.
	stat addDimension: dimension.
	
	actual := stat dimensions first.
	actual should beReturnedFrom: [ dimension asObjectStatDimension  ].
	actual should receive overallStatistics: stat
]

{ #category : #tests }
ObjectStatisticsTests >> testAddNewDimensionByBlock [

	| stat actual block |
	block := [:o | o class].
	stat := ObjectStatistics new.
	stat addDimension: block.
	
	actual := stat dimensions first.
	actual should beInstanceOf: ObjectStatDimension.
	actual where coordinatesBlock should be: block
]

{ #category : #tests }
ObjectStatisticsTests >> testAddNewDimensionWithName [

	| dimension stat actual result |
	dimension := Mock new.
	stat := ObjectStatistics new.
	result := stat dimension: dimension named: 'test dimension'.
	
	actual := stat dimensions first.
	actual should receive name: 'test dimension'.
	result should be: actual
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddNewMetric [

	| metric actual stat returned |
	metric := Mock new.
	stat := ObjectStatistics new.
	returned := stat addMetric: metric.
	
	actual := stat metrics first.
	actual should beReturnedFrom: [ metric asObjectStatMetric ].
	actual should be: returned
]

{ #category : #tests }
ObjectStatisticsTests >> testAddNewMetricByBlock [

	| stat actual block |
	block := [:o | 2].
	stat := ObjectStatistics new.
	stat addMetric: block.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatFunctionMetric.
	actual where functionBlock should be: block
]

{ #category : #tests }
ObjectStatisticsTests >> testAddNewMetricWithName [

	| metric stat actual returned |
	metric := Mock new.
	stat := ObjectStatistics new.
	returned := stat addMetric: metric named: 'test dimension'.
	
	actual := stat metrics first.
	actual should receive name: 'test dimension'.
	returned should be: actual
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingCounterMetric [

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countAllAs: 'objects name'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatCounter.
	actual name should equal: 'objects name'
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingCounterMetricForSetOfObjects [

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countAllSuch: [:number | number even ] as: 'objects name'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatCounter.
	actual name should equal: 'objects name'.
	actual objectsSpec should beInstanceOf: SpecOfObjectStateByPredicate	
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingDifferentPropertiesCountMetric [

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countDifferent: [ :o | o class ] as: 'classes'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatDifferentPropertiesCounter.
	actual name should equal: 'classes'
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingDifferentPropertiesCountMetricForSetOfObjects [

	| stat actual objectsSpec |
	stat := ObjectStatistics new.
	objectsSpec := Kind of: Rectangle.
	stat countDifferent: [ :o | o class ] as: 'classes' for: objectsSpec.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatDifferentPropertiesCounter.
	actual name should equal: 'classes'.
	actual objectsSpec should be: objectsSpec.
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingDimensionWithIgnoreMetricsByFluentAPI [

	| stat dimension |
	dimension := ObjectStatDimension new.
	
	stat := ObjectStatistics new.
	
	stat 
		dimension: dimension named: 'dim1';
		with: [ stat ignoreMetrics: #ignoredMetricNames].
		
	stat dimensions where first should be: dimension.
	stat dimensions where first ignoreMetricNames should be: #ignoredMetricNames
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingDimensionsForSetOfObjectsByFluentAPI [

	| stat dimension subDimension objectsSpec |
	dimension := ObjectStatDimension new.
	subDimension := ObjectStatDimension new.
	objectsSpec := Kind of: Point.
	
	stat := ObjectStatistics new.	
	stat 
		dimension: dimension named: 'dim1';
		for: objectsSpec with: [ 
			stat dimension: subDimension named: 'dim2'].
	
	stat dimensions should haveSize: 1.		
	stat dimensions where first should be: dimension.
	stat dimensions where first subDimensions first should be: subDimension.
	subDimension objectsSpec should be: objectsSpec
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingDimensionsTreeByFluentAPI [

	| stat dimension1 dimension2 dimension3 dimension4 |
	dimension1 := ObjectStatDimension new.
	dimension2 := ObjectStatDimension new.
	dimension3 := ObjectStatDimension new.
	dimension4 := ObjectStatDimension new.
	
	stat := ObjectStatistics new.
	
	stat 
		dimension: dimension1 named: 'dim1';
		with: [ 
			stat 
				dimension: dimension2 named: 'dim2';
				dimension: dimension3 named: 'dim3' ];
		dimension: dimension4 named: 'dim4'.
	
	stat dimensions where first should be: dimension1.
	stat dimensions where last should be: dimension4.
	stat dimensions where first subDimensions first should be: dimension2.
	stat dimensions where first subDimensions last should be: dimension3.
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingFunctionCountMetric [

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countFunction: [ :o | o count: #isVowel ] as: 'vowels'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatFunctionMetric.
	actual name should equal: 'vowels'
	
]

{ #category : #tests }
ObjectStatisticsTests >> testAddingRecursiveDimension [

	| stat dimension |
	stat := ObjectStatistics new.	
	stat dimension: #coordinatesBlock named: 'dim1' recursionUpTo: #parentPropertyBlock.
	
	stat dimensions should haveSize: 1.		
	dimension := stat dimensions first.
	dimension should beInstanceOf: ObjectStatRecursiveDimension.
	dimension coordinatesBlock should be: #coordinatesBlock.
	dimension parentRecursionBlock should be: #parentPropertyBlock.
	dimension name should equal: 'dim1'
]

{ #category : #tests }
ObjectStatisticsTests >> testCreationNewStatForDimension [

	| stat actual |
	[:metric1 :metric2 :dimension |
		stat := ObjectStatistics new.
		stat metrics: { metric1. metric2 }.
		stat dimensions: #currentDimensions.

		actual := stat newForDimension: dimension.
	
		actual should beInstanceOf: ObjectStatistics.
		dimension should receive prepareStatistics: actual.
		actual metrics should haveSize: 2.
		actual metrics first should beReturnedFrom: [ metric1 newForDimension ].
		actual metrics last should beReturnedFrom: [ metric2 newForDimension ]
		
	] runWithMocks 
]

{ #category : #tests }
ObjectStatisticsTests >> testCreationNewStatForDimensionShouldNotAddIgnoredMetrics [

	| stat actual |
	[:metric1 :metric2 :dimension |
		stat := ObjectStatistics new.
		stat metrics: { metric1. metric2 }.
		stat dimensions: #currentDimensions.
		(dimension stub isIgnoreMetric: metric2) willReturn: true.

		actual := stat newForDimension: dimension.
	
		actual should beInstanceOf: ObjectStatistics.
		dimension should receive prepareStatistics: actual.
		actual metrics should haveSize: 1.
		actual metrics first should beReturnedFrom: [ metric1 newForDimension ].
		metric2 should not receive newForDimension.
		
	] runWithMocks 
]

{ #category : #tests }
ObjectStatisticsTests >> testHasEmptyDimensionsByDefault [

	| stat |
	stat := ObjectStatistics new.
	
	stat where dimensions should be isEmpty
]

{ #category : #tests }
ObjectStatisticsTests >> testHasEmptyMetricsByDefault [

	| stat |
	stat := ObjectStatistics new.
	
	stat where metrics should be isEmpty
]
