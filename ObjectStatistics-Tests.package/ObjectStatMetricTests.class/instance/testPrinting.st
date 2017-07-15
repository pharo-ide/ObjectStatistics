tests
testPrinting

	| metric |
	metric := ObjectStatMetric new.
	metric parent: ObjectStatMetric new.
	metric stub percentage willReturn: 10.2356.
	metric value: 1000.
	
	metric printString should equal: '1000 (10.24%)'