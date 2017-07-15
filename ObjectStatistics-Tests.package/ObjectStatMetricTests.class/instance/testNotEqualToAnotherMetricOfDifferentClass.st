tests
testNotEqualToAnotherMetricOfDifferentClass

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 'value1'.
	
	metric2 := Mock new.
	
	metric should not be = metric2