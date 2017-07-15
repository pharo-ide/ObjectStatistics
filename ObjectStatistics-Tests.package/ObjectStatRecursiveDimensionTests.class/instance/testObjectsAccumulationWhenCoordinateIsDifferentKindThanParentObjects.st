tests
testObjectsAccumulationWhenCoordinateIsDifferentKindThanParentObjects

	| stat dim stop |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext.
	dim := stat 
		dimension: [ :context | context receiver class ] named: 'calls' 
		recursionUpTo: [:context |context == stop ifTrue: [ nil ] ifFalse: [ context sender ] ].
	dim shouldCountChildrenInParentMetrics: false.
		
	stat accumulate: thisContext.
	self childCall1To: stat.
	self childCall2To: stat.
	
	stat mainMetric value should be: 3