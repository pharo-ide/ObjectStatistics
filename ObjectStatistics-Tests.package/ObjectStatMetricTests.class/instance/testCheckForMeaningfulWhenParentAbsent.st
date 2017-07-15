tests
testCheckForMeaningfulWhenParentAbsent

	| metric |
	metric := ObjectStatMetric new.
	metric parent: nil.
	
	metric should be isMeaningful