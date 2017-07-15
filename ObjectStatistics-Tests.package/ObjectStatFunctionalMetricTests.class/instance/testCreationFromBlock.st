tests
testCreationFromBlock

	| metric block |
	block := [ :o |  ].
	
	metric := block asObjectStatMetric.
		
	metric should beInstanceOf: ObjectStatFunctionMetric.
	metric functionBlock should be: block