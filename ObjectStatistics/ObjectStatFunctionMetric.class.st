"
I am metric which accumulate given function value over all objects set.

Internal Representation and Key Implementation Points.

    Instance Variables
	functionBlock:		<BlockClosure>

"
Class {
	#name : #ObjectStatFunctionMetric,
	#superclass : #ObjectStatMetric,
	#instVars : [
		'functionBlock'
	],
	#category : 'ObjectStatistics'
}

{ #category : #'instance creation' }
ObjectStatFunctionMetric class >> by: aBlockClosure [ 
	^self new 
		functionBlock: aBlockClosure 
]

{ #category : #'instance creation' }
ObjectStatFunctionMetric class >> named: aString by: aBlockClosure [ 
	^(self named: aString)
		functionBlock: aBlockClosure 
		
]

{ #category : #accessing }
ObjectStatFunctionMetric >> functionBlock [
	^ functionBlock
]

{ #category : #accessing }
ObjectStatFunctionMetric >> functionBlock: anObject [
	functionBlock := anObject
]

{ #category : #measuring }
ObjectStatFunctionMetric >> measure: anObject [
	^functionBlock value: anObject
]
