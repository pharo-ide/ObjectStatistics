tests
testComputingPercentage

	| metric parentMetric |
	parentMetric := Mock new.
	parentMetric stub value willReturn: 1000.
	metric := ObjectStatMetric new.
	metric parent: parentMetric.
	metric value: 100.
	
	metric percentage should equal: 10