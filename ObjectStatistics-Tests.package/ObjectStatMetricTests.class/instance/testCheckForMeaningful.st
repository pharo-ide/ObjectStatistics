tests
testCheckForMeaningful

	| metric parent |
	parent := ObjectStatMetric new.
	metric := ObjectStatMetric new.
	metric parent: parent.
	
	parent value: 10.
	metric should be isMeaningful.
	
	parent value: 0.
	metric should not be isMeaningful.