tests
testObjectsAccumulationWhenSomeNotSatisfiedObjectSpec

	| slice stat stop dim |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext sender sender.
	dim := stat 
		dimension: [ :context | context ] named: 'calls' 
		recursionUpTo: [:context |context == stop ifTrue: [ nil ] ifFalse: [ context sender ] ].
	dim objectsSpec: (Identical to: thisContext sender) not.
	dim shouldCountChildrenInParentMetrics: false.

	stat accumulate: thisContext sender sender.
	stat accumulate: thisContext sender.
	stat accumulate: thisContext.
	stat accumulate: thisContext.
	
	stat mainMetric value should be: 4.
	slice := (stat dimensionNamed: 'calls') sliceFor: thisContext sender sender.
	slice mainMetric value should be: 1.
	(slice dimensionNamed: 'calls') should not be hasSliceFor: thisContext sender.
	slice := (slice dimensionNamed: 'calls') sliceFor: thisContext.
	slice mainMetric value should be: 2