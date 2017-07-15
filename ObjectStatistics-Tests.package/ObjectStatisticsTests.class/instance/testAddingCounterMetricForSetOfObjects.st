tests
testAddingCounterMetricForSetOfObjects

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countAllSuch: [:number | number even ] as: 'objects name'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatCounter.
	actual name should equal: 'objects name'.
	actual objectsSpec should beInstanceOf: SpecOfObjectStateByPredicate	
	