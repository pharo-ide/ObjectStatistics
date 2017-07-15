tests
testMeasureObjects

	| object metric actual |
	object := Mock new.
	object stub someMetric willReturn: #result.
	
	metric := [ :o | o someMetric ] asObjectStatMetric.
	
	actual := metric measure: object.
	
	actual should be: #result.