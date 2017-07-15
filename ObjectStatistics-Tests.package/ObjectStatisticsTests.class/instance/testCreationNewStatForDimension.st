tests
testCreationNewStatForDimension

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