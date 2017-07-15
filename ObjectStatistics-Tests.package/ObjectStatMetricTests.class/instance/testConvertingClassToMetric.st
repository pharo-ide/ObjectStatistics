tests
testConvertingClassToMetric

	| metric |
	
	metric := ObjectStatMetric asObjectStatMetric.
	
	metric should beInstanceOf: ObjectStatMetric 