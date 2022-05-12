"
I represent dimension in space of objects.
You can think about me as dimension of object classes, dimension of object packages and etc.

During statistics accumulation I receive measured objects. For every object I retrive concrete coordinate in object space. It calculated by my coordinatesBlock. In this coordinate I create new statistics and add given object into it.  Coordinate value and statistics are incapsulated in ObjectStatSlice instance. At the end of objects analysis I contain set of slices where each slice includes own statistics in particular dimension coordinate.

I have own sub dimensions which play same role as dimensions inside statistics. Each statistics in my slices will include my sub dimensions.
It allows to define hierarchy of dimension for statistics analysis.

I have also objectsSpec which specified set of objects which could be accumulated by me. It allows to define dimensions for subset of objects space.

For more information look at ObjectStatistics comment.

Public API and Key Messages

- accumulate: anObject
it adds given object into statistics which defined for corresponding coordinate in objects space

- accumulateAll: aCollection
it accumulates all collection items
 
Internal Representation and Key Implementation Points.

    Instance Variables
	ignoreMetricNames:		<Array of: <String>>
	name:		<String>
	objectsSpec:		<SpecOfObjectState>
	overallStatistics:		<ObjectStatistics>
	slices:		<Dictionary of: <ObjectStatSlice>>
	coordinatesBlock:		<BlockClosure>
	subDimensions:		<OrderedCollection of: <ObjectStatDimension>>
"
Class {
	#name : #ObjectStatDimension,
	#superclass : #Object,
	#instVars : [
		'name',
		'overallStatistics',
		'slices',
		'subDimensions',
		'ignoreMetricNames',
		'objectsSpec',
		'coordinatesBlock'
	],
	#category : #ObjectStatistics
}

{ #category : #'instance creation' }
ObjectStatDimension class >> by: aBlockClosure [ 
	^self new 
		coordinatesBlock: aBlockClosure 
]

{ #category : #'instance creation' }
ObjectStatDimension class >> named: aString [
	^self new 
		name: aString
]

{ #category : #'instance creation' }
ObjectStatDimension class >> of: anObjectStatistics [
	^self new 
		overallStatistics: anObjectStatistics 
]

{ #category : #measuring }
ObjectStatDimension >> accumulate: anObject [

	| slice |
	(objectsSpec matches: anObject) ifFalse: [ ^self ].
	
	slice := self sliceFor: anObject.
	
	slice accumulate: anObject
]

{ #category : #measuring }
ObjectStatDimension >> accumulateAll: aCollection [

	^aCollection do: [ :each | self accumulate: each ]
]

{ #category : #accessing }
ObjectStatDimension >> addDimension: anObjectStatDimension [

	subDimensions add: anObjectStatDimension.
	^anObjectStatDimension
]

{ #category : #converting }
ObjectStatDimension >> asObjectStatDimension [
	^self
]

{ #category : #measuring }
ObjectStatDimension >> coordinateFor: anObject [
	^coordinatesBlock value: anObject 
]

{ #category : #accessing }
ObjectStatDimension >> coordinatesBlock [
	^ coordinatesBlock
]

{ #category : #accessing }
ObjectStatDimension >> coordinatesBlock: anObject [
	coordinatesBlock := anObject
]

{ #category : #accessing }
ObjectStatDimension >> copyForSubDimension [

	| copy |
	copy := self copy.
	copy slices: Dictionary new.
	^copy
]

{ #category : #accessing }
ObjectStatDimension >> dimension: aDimensionOrBlock named: aString [

	| dimension |
	dimension := aDimensionOrBlock asObjectStatDimension.
	dimension name: aString.
	
	subDimensions add: dimension.
	^dimension
	
]

{ #category : #testing }
ObjectStatDimension >> hasSliceFor: anObject [

	| coordinateObject |
	coordinateObject := self coordinateFor: anObject.
	
	^slices includesKey: coordinateObject
]

{ #category : #accessing }
ObjectStatDimension >> ignoreMetricNames [
	^ignoreMetricNames
]

{ #category : #accessing }
ObjectStatDimension >> ignoreMetrics: metricNames [ 
	ignoreMetricNames := metricNames
]

{ #category : #initialization }
ObjectStatDimension >> initialize [
	super initialize.
	
	slices := Dictionary new.
	subDimensions := OrderedCollection new.
	ignoreMetricNames := Array empty.
	objectsSpec := Any
]

{ #category : #testing }
ObjectStatDimension >> isEmpty [
	^slices isEmpty
]

{ #category : #testing }
ObjectStatDimension >> isIgnoreMetric: anObjectStatMetric [ 
	^ignoreMetricNames includes: anObjectStatMetric name
]

{ #category : #accessing }
ObjectStatDimension >> lastDimension [
	^subDimensions last
]

{ #category : #accessing }
ObjectStatDimension >> name [
	^ name
]

{ #category : #accessing }
ObjectStatDimension >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ObjectStatDimension >> objectsSpec [
	^ objectsSpec
]

{ #category : #accessing }
ObjectStatDimension >> objectsSpec: anObject [
	objectsSpec := anObject asStateSpec 
]

{ #category : #accessing }
ObjectStatDimension >> overallStatistics [
	^ overallStatistics
]

{ #category : #accessing }
ObjectStatDimension >> overallStatistics: anObject [
	overallStatistics := anObject
]

{ #category : #accessing }
ObjectStatDimension >> prepareStatistics: anObjectStatistics [

	subDimensions do: [ :each | 
		anObjectStatistics addDimension: each copyForSubDimension]
]

{ #category : #printing }
ObjectStatDimension >> printOn: aStream [
	name ifNil: [ ^super printOn: aStream ].
	
	aStream 
		print: slices size;
		nextPutAll: ' ';
		nextPutAll: name
]

{ #category : #accessing }
ObjectStatDimension >> sliceFor: anObject [

	| coordinateObject |
	coordinateObject := self coordinateFor: anObject.
	
	^slices at: coordinateObject ifAbsentPut: [ 
		ObjectStatSlice at: coordinateObject statistics: (overallStatistics newForDimension: self)  ]
]

{ #category : #accessing }
ObjectStatDimension >> slices [
	^ slices
]

{ #category : #accessing }
ObjectStatDimension >> slices: anObject [
	slices := anObject
]

{ #category : #accessing }
ObjectStatDimension >> sortedSlices [ 

	^slices asSortedCollection: [ :a :b | a mainMetric > b mainMetric]
]

{ #category : #accessing }
ObjectStatDimension >> subDimensions [
	^ subDimensions
]

{ #category : #accessing }
ObjectStatDimension >> subDimensions: anObject [
	subDimensions := anObject
]
