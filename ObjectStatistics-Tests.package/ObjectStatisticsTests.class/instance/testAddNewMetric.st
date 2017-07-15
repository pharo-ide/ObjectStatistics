tests
testAddNewMetric

	| metric actual stat returned |
	metric := Mock new.
	stat := ObjectStatistics new.
	returned := stat addMetric: metric.
	
	actual := stat metrics first.
	actual should beReturnedFrom: [ metric asObjectStatMetric ].
	actual should be: returned