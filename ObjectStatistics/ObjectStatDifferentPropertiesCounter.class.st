"
I am metric which count how many different properties objects have.
For example I could be used to count receivers of messages set.

Internal Representation and Key Implementation Points.

    Instance Variables
	measuredProperties:		<IdentitySet>
	propertyBlock:		<BlockClosure>

"
Class {
	#name : #ObjectStatDifferentPropertiesCounter,
	#superclass : #ObjectStatMetric,
	#instVars : [
		'measuredProperties',
		'propertyBlock'
	],
	#category : 'ObjectStatistics'
}

{ #category : #'instance creation' }
ObjectStatDifferentPropertiesCounter class >> for: aBlockClosure [ 
	^self new 
		propertyBlock: aBlockClosure 
]

{ #category : #initialization }
ObjectStatDifferentPropertiesCounter >> initialize [
	super initialize.
	
	measuredProperties := IdentitySet new
]

{ #category : #measuring }
ObjectStatDifferentPropertiesCounter >> measure: anObject [
	| currentSize propertyValue |
	currentSize := measuredProperties size.
	
	propertyValue := propertyBlock value: anObject.
	propertyValue isArray 
		ifTrue: [ measuredProperties addAll: propertyValue ]
		ifFalse: [ measuredProperties add: propertyValue].
	
	^measuredProperties size - currentSize 
]

{ #category : #accessing }
ObjectStatDifferentPropertiesCounter >> measuredProperties [
	^ measuredProperties
]

{ #category : #accessing }
ObjectStatDifferentPropertiesCounter >> measuredProperties: anObject [
	measuredProperties := anObject
]

{ #category : #accessing }
ObjectStatDifferentPropertiesCounter >> prepareForDimensionOf: anObjectStatDimension [
	super prepareForDimensionOf: anObjectStatDimension.
	
	measuredProperties := IdentitySet new
	
]

{ #category : #accessing }
ObjectStatDifferentPropertiesCounter >> propertyBlock [
	^ propertyBlock
]

{ #category : #accessing }
ObjectStatDifferentPropertiesCounter >> propertyBlock: anObject [
	propertyBlock := anObject
]
