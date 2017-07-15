accessing
addMetric: metricSource named: aString 
	| metric |
	metric := self addMetric: metricSource.
	metric name: aString.
	^metric