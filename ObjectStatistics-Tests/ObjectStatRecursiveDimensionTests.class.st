Class {
	#name : #ObjectStatRecursiveDimensionTests,
	#superclass : #TestCase,
	#instVars : [
		'childCall1',
		'childCall2'
	],
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> childCall1To: stat [
	childCall1 := thisContext.
	stat accumulate: childCall1
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> childCall2To: stat [
	childCall2 := thisContext.
	stat accumulate: childCall2
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenChildrenShouldBeCountInParents [

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
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenChildrenShouldNotBeCountInParents [

	| slice stat stop dim |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext sender sender.
	dim := stat 
		dimension: [ :context | context ] named: 'calls' 
		recursionUpTo: [:context |context == stop ifTrue: [ nil ] ifFalse: [ context sender ] ].
	dim shouldCountChildrenInParentMetrics: false.

	stat accumulate: thisContext sender sender.
	stat accumulate: thisContext sender.
	stat accumulate: thisContext.
	stat accumulate: thisContext.
		
	stat mainMetric value should be: 4.
	slice := (stat dimensionNamed: 'calls') sliceFor: thisContext sender sender.
	slice mainMetric value should be: 1.
	slice := (slice dimensionNamed: 'calls') sliceFor: thisContext sender.
	slice mainMetric value should be: 1.
	slice := (slice dimensionNamed: 'calls') sliceFor: thisContext.
	slice mainMetric value should be: 2
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenCoordinateIsDifferentKindThanParentObjects [

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
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenCoordinateIsDifferentKindThanParentObjectsAndFullStack [

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
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenNoChildren [

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
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenSomeNotSatisfiedObjectSpec [

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
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWhenSomeNotSatisfiedObjectSpecAndChildrenShouldBeCountInParentMetrics [

	| slice stat stop dim |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stop := thisContext sender sender.
	dim := stat 
		dimension: [ :context | context ] named: 'calls' 
		recursionUpTo: [:context |context == stop ifTrue: [ nil ] ifFalse: [ context sender ] ].
	dim objectsSpec: (Identical to: thisContext sender) not.
	dim shouldCountChildrenInParentMetrics: true.

	stat accumulate: thisContext sender sender.
	stat accumulate: thisContext sender.
	stat accumulate: thisContext.
	stat accumulate: thisContext.
	
	stat mainMetric value should be: 4.
	slice := (stat dimensionNamed: 'calls') sliceFor: thisContext sender sender.
	slice mainMetric value should be: 3.
	(slice dimensionNamed: 'calls') should not be hasSliceFor: thisContext sender.
	slice := (slice dimensionNamed: 'calls') sliceFor: thisContext.
	slice mainMetric value should be: 2
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testObjectsAccumulationWithFullStackRecursion [

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
]

{ #category : #tests }
ObjectStatRecursiveDimensionTests >> testShouldNotCountChildrenInParentMetricsByDefault [

	| dimension |
	dimension := ObjectStatRecursiveDimension new.
			
	dimension should not be shouldCountChildrenInParentMetrics 
]
