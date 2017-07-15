tests
testResultAccumulationShouldSkipObjectsWhichNotMatchesSpec

	| metric result |
	metric := ObjectStatMetric new.
	metric objectsSpec: [:o | o == #object1].  
	(metric stub measure: #object1) willReturn: 10.
	
	metric accumulate: #object1.
	metric value should be: 10.	
	result := metric accumulate: #object2.
	metric value should be: 10.
	result should be: 10.
	
	metric should not receive measure: #object2