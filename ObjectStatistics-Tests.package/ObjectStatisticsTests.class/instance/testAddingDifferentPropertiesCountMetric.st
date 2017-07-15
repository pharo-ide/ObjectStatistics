tests
testAddingDifferentPropertiesCountMetric

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countDifferent: [ :o | o class ] as: 'classes'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatDifferentPropertiesCounter.
	actual name should equal: 'classes'
	