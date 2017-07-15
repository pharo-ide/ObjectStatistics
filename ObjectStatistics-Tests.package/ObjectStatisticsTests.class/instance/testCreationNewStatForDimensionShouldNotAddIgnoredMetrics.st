tests
testCreationNewStatForDimensionShouldNotAddIgnoredMetrics

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