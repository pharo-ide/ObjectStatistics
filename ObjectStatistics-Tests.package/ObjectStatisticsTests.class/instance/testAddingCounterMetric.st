tests
testAddingCounterMetric

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countAllAs: 'objects name'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatCounter.
	actual name should equal: 'objects name'
	