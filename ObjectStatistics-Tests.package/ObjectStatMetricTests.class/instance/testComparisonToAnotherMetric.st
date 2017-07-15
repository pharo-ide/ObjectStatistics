tests
testComparisonToAnotherMetric

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 2.
	
	metric2 := ObjectStatMetric new.
	metric2 value: 3.
	
	metric should be < metric2.
	metric2 should be > metric.