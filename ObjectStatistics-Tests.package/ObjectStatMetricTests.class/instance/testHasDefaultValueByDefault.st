tests
testHasDefaultValueByDefault

	| metric |
	metric := ObjectStatMetric new.
	
	metric value should be: metric defaultValue