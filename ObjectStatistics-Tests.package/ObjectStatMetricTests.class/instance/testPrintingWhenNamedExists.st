tests
testPrintingWhenNamedExists

	| metric |
	metric := ObjectStatMetric named: 'test params'.
	metric parent: ObjectStatMetric new.
	metric stub percentage willReturn: 10.2356.
	metric value: 1000.
	
	metric printString should equal: '1000 test params (10.24%)'