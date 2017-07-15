tests
testConvertingToMetric

	| metric |
	
	metric := ObjectStatMetric new.
	
	metric where asObjectStatMetric should be: metric