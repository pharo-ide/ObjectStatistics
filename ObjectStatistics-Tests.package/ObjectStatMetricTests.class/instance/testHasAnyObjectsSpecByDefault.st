tests
testHasAnyObjectsSpecByDefault

	| metric |
	metric := ObjectStatMetric new.
	
	(metric objectsSpec == Any) should be: true