Class {
	#name : #ObjectStatCounterTests,
	#superclass : #TestCase,
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatCounterTests >> testMeasureObjects [

	| counter |
	counter := ObjectStatCounter new.

	(counter measure: Any) should be: 1.
	(counter measure: Any) should be: 1
]
