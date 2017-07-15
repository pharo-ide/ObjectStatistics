tests
testResultAccumulation

	| metric result |
	metric := ObjectStatMetric new.
	(metric stub measure: #object1) willReturn: 10.
	(metric stub measure: #object2) willReturn: 20.
	
	metric accumulate: #object1.
	metric value should be: 10.
	
	result := metric accumulate: #object2.
	metric value should be: 30.
	result should be: 30