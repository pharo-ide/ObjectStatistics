"
I represent slice of overall objects statistics.
I am created by dimensions for every objects coordinate to maintain own sub statistics..

Public API and Key Messages

- accumulate: anObject
it adds given object to my own statistics.   
 
Internal Representation and Key Implementation Points.

    Instance Variables
	coordinate:		<Object>
	statistics:		<ObjectStatistics>


    Implementation Points
"
Class {
	#name : #ObjectStatSlice,
	#superclass : #Object,
	#instVars : [
		'statistics',
		'coordinate'
	],
	#category : 'ObjectStatistics'
}

{ #category : #'instance creation' }
ObjectStatSlice class >> at: coordinateObject statistics: anObjectStatistics [
	^self new 
		coordinate: coordinateObject;
		statistics: anObjectStatistics 
]

{ #category : #measuring }
ObjectStatSlice >> accumulate: anObject [ 
	^statistics accumulate: anObject
]

{ #category : #measuring }
ObjectStatSlice >> accumulate: anObject exceptingDimension: dimensionName [
	^statistics accumulate: anObject exceptingDimension: dimensionName
]

{ #category : #accessing }
ObjectStatSlice >> coordinate [
	^ coordinate
]

{ #category : #accessing }
ObjectStatSlice >> coordinate: anObject [
	coordinate := anObject
]

{ #category : #accessing }
ObjectStatSlice >> dimensionNamed: aString [ 
	^statistics dimensionNamed: aString
]

{ #category : #accessing }
ObjectStatSlice >> mainMetric [
	^statistics mainMetric
]

{ #category : #printing }
ObjectStatSlice >> printOn: aStream [
	
	coordinate printOn: aStream.
	aStream << ': '.
	statistics printMetricsOn: aStream
]

{ #category : #accessing }
ObjectStatSlice >> statistics [
	^ statistics
]

{ #category : #accessing }
ObjectStatSlice >> statistics: anObject [
	statistics := anObject
]
