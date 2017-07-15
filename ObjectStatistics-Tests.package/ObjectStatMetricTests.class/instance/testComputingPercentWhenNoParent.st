tests
testComputingPercentWhenNoParent

	| metric |
	metric := ObjectStatMetric new.
	metric parent: nil.
	metric value: Any.
	
	metric percentage should equal: 100