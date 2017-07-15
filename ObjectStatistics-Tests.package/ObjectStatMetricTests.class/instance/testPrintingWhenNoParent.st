tests
testPrintingWhenNoParent

	| metric |
	metric := ObjectStatMetric new.
	metric parent: nil.
	metric value: 1000.
	
	metric printString should equal: '1000'