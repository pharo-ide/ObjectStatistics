tests
testMeasureObjectsWhenPropertyIsCollection

	| counter |
	counter := ObjectStatDifferentPropertiesCounter for: [:o | o first] .

	(counter measure: #(#object)) should be: 1.
	(counter measure: #(#(#object #object2 #object3)) copy) should be: 2.