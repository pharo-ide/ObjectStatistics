tests
testEqualToItself

	| metric |
	metric := ObjectStatMetric new.
	metric value: #value1.
	
	metric should be = metric