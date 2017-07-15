tests
testObjectsAccumulationWhenCoordinateIsDifferentKindThanParentObjectsAndFullStack

	| stat dim stop slices |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext.
	dim := stat 
		dimension: [ :context | context receiver class ] named: 'calls' 
		recursionUpTo: [:context | context sender].
	dim shouldCountChildrenInParentMetrics: false.

	stat accumulate: thisContext.
	self childCall1To: stat.	
	self childCall2To: stat.

	stat mainMetric value should be: 3.
	(slices := (stat dimensionNamed: 'calls') sortedSlices) should haveSize: 1.
	(slices first dimensionNamed: 'calls') sortedSlices should haveSize: 1