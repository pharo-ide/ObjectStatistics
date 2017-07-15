tests
testCheckThatMetricIsIgnored

	| dimension |
	dimension := ObjectStatDimension new.
	dimension ignoreMetrics: #('metric1Name' 'metric2Name').
	
	dimension should be isIgnoreMetric: (ObjectStatMetric named: 'metric1Name').
	dimension should be isIgnoreMetric: (ObjectStatMetric named: 'metric2Name').
	
	dimension should not be isIgnoreMetric: (ObjectStatMetric named: 'someOtherMetric')