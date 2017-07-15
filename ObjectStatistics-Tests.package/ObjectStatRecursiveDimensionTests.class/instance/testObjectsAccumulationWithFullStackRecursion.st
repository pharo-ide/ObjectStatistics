tests
testObjectsAccumulationWithFullStackRecursion

	| stat dim |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	dim := stat 
		dimension: [ :context | context ] named: 'calls' 
		recursionUpTo: [:context | context sender ].
		
	stat accumulate: thisContext sender sender.
	stat accumulate: thisContext sender.
	stat accumulate: thisContext.
	stat accumulate: thisContext.
		
	stat mainMetric value should be: 4