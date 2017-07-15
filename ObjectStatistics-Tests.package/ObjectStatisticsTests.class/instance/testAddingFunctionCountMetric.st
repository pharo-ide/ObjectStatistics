tests
testAddingFunctionCountMetric

	| stat actual |
	stat := ObjectStatistics new.
	
	stat countFunction: [ :o | o count: #isVowel ] as: 'vowels'.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatFunctionMetric.
	actual name should equal: 'vowels'
	