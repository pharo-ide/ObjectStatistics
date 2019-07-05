"
I am special dimension of object space which unfold separate subdimensions for children of given objects.  I implement this unfolding logic by propagating parents of given objects which I detect by my parentRecursionBlock.

For example I allow implement classic profiler tree statistics where we see number of message sends inside each call in tree view.
Look at my tests ObjectStatRecursiveDimensionTests or profiler example:
	ObjectStatistics exampleTreeProfiler

My ownerObjects is all objects which are folded by same coordinate and all their children together should belongs to me. 

Internal Representation and Key Implementation Points.

    Instance Variables
	ownerObjects		<Set of: <Object>>
	parentRecursionBlock:		<BlockClosure>
	shouldCountChildrenInParentMetrics:		<Boolean>
"
Class {
	#name : #ObjectStatRecursiveDimension,
	#superclass : #ObjectStatDimension,
	#instVars : [
		'shouldCountChildrenInParentMetrics',
		'parentRecursionBlock',
		'ownerObjects'
	],
	#category : 'ObjectStatistics'
}

{ #category : #'instance creation' }
ObjectStatRecursiveDimension class >> by: slicesBlock recursion: propertyBlock [
	^(self by: slicesBlock)
		parentRecursionBlock: propertyBlock 
]

{ #category : #measuring }
ObjectStatRecursiveDimension >> accumulate: anObject [

	(objectsSpec matches: anObject ) ifFalse: [ ^self ].
	
	self accumulateParentsOf: anObject whichIsLowermostChild: true

]

{ #category : #private }
ObjectStatRecursiveDimension >> accumulateParentsOf: anObject whichIsLowermostChild: isLowermostChild [

	| currentParent sliceForParent slice |
	currentParent := self findParentOf: anObject.
	
	(ownerObjects includes: currentParent) ifTrue: [ 
		slice := self sliceFor: anObject.
		shouldCountChildrenInParentMetrics | isLowermostChild ifTrue: [ 
			slice accumulate: anObject exceptingDimension: name].
		^slice].
	
	sliceForParent := self accumulateParentsOf: currentParent whichIsLowermostChild: false.
	^(sliceForParent dimensionNamed: name) 
		accumulateParentsOf: anObject whichIsLowermostChild: isLowermostChild
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> addOwnerObject: anObject [
	ownerObjects add: anObject
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> copyForSubDimension [ 
	| copy |
	copy := super copyForSubDimension.
	copy ownerObjects: Set new.
	^copy
]

{ #category : #private }
ObjectStatRecursiveDimension >> findParentOf: anObject [

	| parent |
	parent := parentRecursionBlock value: anObject.
	
	[objectsSpec matches: parent] whileFalse: [
		parent := parentRecursionBlock value: parent].	

	^parent
]

{ #category : #initialization }
ObjectStatRecursiveDimension >> initialize [
	super initialize.
	ownerObjects := Set new.
	ownerObjects add: nil.
	shouldCountChildrenInParentMetrics := false
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> ownerObjects [
	^ ownerObjects
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> ownerObjects: aSet [
	ownerObjects := aSet
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> parentRecursionBlock [
	^ parentRecursionBlock
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> parentRecursionBlock: anObject [
	parentRecursionBlock := anObject
]

{ #category : #private }
ObjectStatRecursiveDimension >> prepareStatistics: anObjectStatistics [
	
	super prepareStatistics: anObjectStatistics.
	
	anObjectStatistics addDimension: self copyForSubDimension
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> shouldCountChildrenInParentMetrics [
	^ shouldCountChildrenInParentMetrics
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> shouldCountChildrenInParentMetrics: anObject [
	shouldCountChildrenInParentMetrics := anObject
]

{ #category : #accessing }
ObjectStatRecursiveDimension >> sliceFor: anObject [

	| slice |
	slice := super sliceFor: anObject.

	(slice dimensionNamed: name) addOwnerObject: anObject.

	^slice	
]
