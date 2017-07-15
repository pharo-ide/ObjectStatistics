tests
testAddNewMetricWithName

	| metric stat actual returned |
	metric := Mock new.
	stat := ObjectStatistics new.
	returned := stat addMetric: metric named: 'test dimension'.
	
	actual := stat metrics first.
	actual should receive name: 'test dimension'.
	returned should be: actual
	