accessing
addMetric: metricSource
	| metric |
	metric := metricSource asObjectStatMetric.
	 
	metrics add: metric.
	
	^metric