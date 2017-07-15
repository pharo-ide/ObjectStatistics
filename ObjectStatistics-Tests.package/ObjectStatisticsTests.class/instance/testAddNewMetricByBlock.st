tests
testAddNewMetricByBlock

	| stat actual block |
	block := [:o | 2].
	stat := ObjectStatistics new.
	stat addMetric: block.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatFunctionMetric.
	actual where functionBlock should be: block