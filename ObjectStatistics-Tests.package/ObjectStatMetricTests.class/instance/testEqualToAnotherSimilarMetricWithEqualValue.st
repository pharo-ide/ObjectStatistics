tests
testEqualToAnotherSimilarMetricWithEqualValue

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 'value1'.
	
	metric2 := ObjectStatMetric new.
	metric2 value: 'value1' copy.
	
	metric should be = metric2