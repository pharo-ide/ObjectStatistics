accessing
newForDimension: anObjectStatDimension 
	| newStat newMetrics |
	newStat := self class new.
	newMetrics := metrics 
		reject: [ :each | anObjectStatDimension isIgnoreMetric: each] 
		thenCollect: [ :each | each newForDimension ].
	newStat metrics: newMetrics.
	anObjectStatDimension prepareStatistics: newStat.
	^newStat