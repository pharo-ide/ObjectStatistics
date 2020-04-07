"
I represent metric which should be calculated over objects set. I accumulate only objects which satisfy my objects spec (which is any object by default).

My subclasses should implement #measure: method which compute metric value for single object.

Public API and Key Messages

- accumulate:  anObject
it measures given object and adds computed result into whole value
- accumulateAll: aCollection
it accumulates all collection items.
- measure: anObject 
it should compute metric on single object
- percentage 
returns percentage of value comparing to parent
- value 
returns currently accumulated value of metric

I am a magnitude which means that different metrics could be compared.

Internal Representation and Key Implementation Points.

    Instance Variables
	name:		<String>
	objectsSpec:		<SpecOfObjectState>
	parent:		<ObjectStatMetric>
	value:		<Number>

"
Class {
	#name : #ObjectStatMetric,
	#superclass : #Magnitude,
	#instVars : [
		'name',
		'value',
		'parent',
		'objectsSpec'
	],
	#category : #ObjectStatistics
}

{ #category : #converting }
ObjectStatMetric class >> asObjectStatMetric [
	^self new
]

{ #category : #'instance creation' }
ObjectStatMetric class >> named: aString [
	^self new name: aString
]

{ #category : #testing }
ObjectStatMetric >> < anObjectStatMatric [

	^value < anObjectStatMatric value
]

{ #category : #testing }
ObjectStatMetric >> = anObjectStatMatric [
	self class == anObjectStatMatric class ifFalse: [ ^false ].
	
	^value = anObjectStatMatric value
]

{ #category : #measuring }
ObjectStatMetric >> accumulate: anObject [

	| result |
	(objectsSpec matches: anObject) ifFalse: [ ^value ].
	
	result := self measure: anObject.
	
	^value := value + result
]

{ #category : #measuring }
ObjectStatMetric >> accumulateAll: aCollection [

	aCollection do: [ :each | self accumulate: each ].
	
	^value
]

{ #category : #converting }
ObjectStatMetric >> asObjectStatMetric [
	^self
]

{ #category : #initialization }
ObjectStatMetric >> defaultValue [
	^0
]

{ #category : #hash }
ObjectStatMetric >> hash [
	^value hash
]

{ #category : #initialization }
ObjectStatMetric >> initialize [
	super initialize.
	
	value := self defaultValue.
	objectsSpec := Any
]

{ #category : #testing }
ObjectStatMetric >> isMeaningful [
	parent ifNil: [ ^true ].
	
	^parent value isZero not
]

{ #category : #measuring }
ObjectStatMetric >> measure: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
ObjectStatMetric >> name [
	^ name
]

{ #category : #accessing }
ObjectStatMetric >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ObjectStatMetric >> newForDimension [
	| newMetric |
	newMetric := self copy.
	newMetric prepareForDimensionOf: self.
	
	^newMetric
]

{ #category : #accessing }
ObjectStatMetric >> objectsSpec [
	^ objectsSpec
]

{ #category : #accessing }
ObjectStatMetric >> objectsSpec: valuableOrSpec [

	objectsSpec := valuableOrSpec isStateSpec 
		ifTrue: [ valuableOrSpec ] 
		ifFalse: [ SpecOfObjectStateByPredicate from: valuableOrSpec ]
]

{ #category : #accessing }
ObjectStatMetric >> parent [
	^ parent
]

{ #category : #accessing }
ObjectStatMetric >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
ObjectStatMetric >> percentage [

	parent ifNil: [ ^100 ].
	parent value isZero ifTrue: [ ^0 ].
	
	^value * 100 / parent value 
]

{ #category : #initialization }
ObjectStatMetric >> prepareForDimensionOf: parentMetric [
	
	value := self defaultValue.
	parent := parentMetric.
]

{ #category : #printing }
ObjectStatMetric >> printOn: aStream [

	self value printOn: aStream.
	
	name ifNotNil: [ aStream << ' ' << name ].
	
	parent ifNotNil: [ 
		aStream << ' ('.
		self percentage printOn: aStream showingDecimalPlaces: 2.
		aStream << '%)']
]

{ #category : #accessing }
ObjectStatMetric >> value [
	^value
]

{ #category : #accessing }
ObjectStatMetric >> value: aNumber [
	value := aNumber
]
