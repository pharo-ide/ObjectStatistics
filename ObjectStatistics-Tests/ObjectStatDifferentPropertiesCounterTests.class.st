Class {
	#name : #ObjectStatDifferentPropertiesCounterTests,
	#superclass : #TestCase,
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatDifferentPropertiesCounterTests >> testCreationNewMetricForDimension [

	| metric actual |
	metric := ObjectStatDifferentPropertiesCounter for: [:o | o first].
	
	actual := metric newForDimension.
	
	actual should beInstanceOf: metric class.
	actual measuredProperties should not be: metric measuredProperties
]

{ #category : #tests }
ObjectStatDifferentPropertiesCounterTests >> testMeasureObjects [

	| counter |
	counter := ObjectStatDifferentPropertiesCounter for: [:o | o first] .

	(counter measure: #(#object)) should be: 1.
	(counter measure: #(#object) copy) should be: 0.
	(counter measure: #(#object2)) should be: 1
]

{ #category : #tests }
ObjectStatDifferentPropertiesCounterTests >> testMeasureObjectsWhenPropertyIsCollection [

	| counter |
	counter := ObjectStatDifferentPropertiesCounter for: [:o | o first] .

	(counter measure: #(#object)) should be: 1.
	(counter measure: #(#(#object #object2 #object3)) copy) should be: 2.
]
