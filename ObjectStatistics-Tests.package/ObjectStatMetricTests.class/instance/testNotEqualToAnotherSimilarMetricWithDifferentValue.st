tests
testNotEqualToAnotherSimilarMetricWithDifferentValue

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 'value1'.
	
	metric2 := ObjectStatMetric new.
	metric2 value: 'value2'.
	
	metric should not be = metric2