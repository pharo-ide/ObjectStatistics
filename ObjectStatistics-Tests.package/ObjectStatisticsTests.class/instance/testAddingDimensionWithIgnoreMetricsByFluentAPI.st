tests
testAddingDimensionWithIgnoreMetricsByFluentAPI

	| stat dimension |
	dimension := ObjectStatDimension new.
	
	stat := ObjectStatistics new.
	
	stat 
		dimension: dimension named: 'dim1';
		with: [ stat ignoreMetrics: #ignoredMetricNames].
		
	stat dimensions where first should be: dimension.
	stat dimensions where first ignoreMetricNames should be: #ignoredMetricNames