"
I am helper objects to define statistics dimensions tree by fluent api.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dimensions:		<OrderedCollection>
	objectsSpec:		<SpecOfObjectStat>
"
Class {
	#name : #ObjectStatBuilder,
	#superclass : #Object,
	#instVars : [
		'dimensions',
		'objectsSpec'
	],
	#category : 'ObjectStatistics'
}

{ #category : #'instance creation' }
ObjectStatBuilder class >> for: anObjectStatistics [

	| builder |
	builder := self new.
	builder statistics: anObjectStatistics.
	^builder
]

{ #category : #accessing }
ObjectStatBuilder >> addDimension: anObjectStatDimension [
	| dimension |
	dimension := self currentDimension addDimension: anObjectStatDimension. 
	dimension objectsSpec: objectsSpec.
	^dimension
]

{ #category : #building }
ObjectStatBuilder >> buildDimensionsBy: aBlock [

	self buildLastDimension.
	aBlock value.
	self buildPreviousDimension
]

{ #category : #building }
ObjectStatBuilder >> buildLastDimension [

	dimensions add: self currentDimension lastDimension
]

{ #category : #building }
ObjectStatBuilder >> buildPreviousDimension [

	dimensions removeLast
]

{ #category : #accessing }
ObjectStatBuilder >> currentDimension [
	^dimensions last
]

{ #category : #accessing }
ObjectStatBuilder >> dimensions [
	^ dimensions
]

{ #category : #accessing }
ObjectStatBuilder >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #building }
ObjectStatBuilder >> for: aStateSpec buildDimensionsBy: aBlock [

	| currentObjectsSpec |
	currentObjectsSpec := objectsSpec.
	objectsSpec := aStateSpec.
	self buildDimensionsBy: aBlock.
	objectsSpec := currentObjectsSpec
]

{ #category : #accessing }
ObjectStatBuilder >> ignoreMetrics: metricNames [
	self currentDimension ignoreMetrics: metricNames
]

{ #category : #initialization }
ObjectStatBuilder >> initialize [
	super initialize.
	
	objectsSpec := Any
]

{ #category : #accessing }
ObjectStatBuilder >> objectsSpec [
	^ objectsSpec
]

{ #category : #accessing }
ObjectStatBuilder >> objectsSpec: anObject [
	objectsSpec := anObject
]

{ #category : #accessing }
ObjectStatBuilder >> statistics: anObjectStatistics [ 
	dimensions := OrderedCollection with: anObjectStatistics 
]
