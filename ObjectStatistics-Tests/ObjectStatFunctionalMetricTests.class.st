Class {
	#name : #ObjectStatFunctionalMetricTests,
	#superclass : #TestCase,
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatFunctionalMetricTests >> testCreationFromBlock [

	| metric block |
	block := [ :o |  ].
	
	metric := block asObjectStatMetric.
		
	metric should beInstanceOf: ObjectStatFunctionMetric.
	metric functionBlock should be: block
]

{ #category : #tests }
ObjectStatFunctionalMetricTests >> testMeasureObjects [

	| object metric actual |
	object := Mock new.
	object stub someMetric willReturn: #result.
	
	metric := [ :o | o someMetric ] asObjectStatMetric.
	
	actual := metric measure: object.
	
	actual should be: #result.
]
