tests
testObjectsAccumulationWhenChildrenShouldBeCountInParents

	| slice stat stop dim |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext sender sender.
	dim := stat 
		dimension: [ :context | context ] named: 'calls' 
		recursionUpTo: [:context |context == stop ifTrue: [ nil ] ifFalse: [ context sender ] ].
	dim shouldCountChildrenInParentMetrics: true.
		
	stat accumulate: thisContext sender sender.
	stat accumulate: thisContext sender.
	stat accumulate: thisContext.
	stat accumulate: thisContext.
		
	stat mainMetric value should be: 4.
	slice := (stat dimensionNamed: 'calls') sliceFor: thisContext sender sender.
	slice mainMetric value should be: 4.
	slice := (slice dimensionNamed: 'calls') sliceFor: thisContext sender.
	slice mainMetric value should be: 3.
	slice := (slice dimensionNamed: 'calls') sliceFor: thisContext.
	slice mainMetric value should be: 2