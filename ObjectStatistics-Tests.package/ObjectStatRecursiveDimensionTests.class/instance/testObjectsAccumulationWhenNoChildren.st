tests
testObjectsAccumulationWhenNoChildren

	| stat stop dim slice |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext.
	dim := stat 
		dimension: [ :context | context ] named: 'calls' 
		recursionUpTo: [:context |context == stop ifTrue: [ nil ] ifFalse: [ context sender ] ].
	dim shouldCountChildrenInParentMetrics: false.

	stat accumulate: thisContext.
	stat accumulate: thisContext.
		
	stat mainMetric value should be: 2.
	slice := (stat dimensionNamed: 'calls') sliceFor: thisContext.
	slice mainMetric value should be: 2