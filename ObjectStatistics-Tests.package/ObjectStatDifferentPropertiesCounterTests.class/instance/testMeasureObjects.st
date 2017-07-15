tests
testMeasureObjects

	| counter |
	counter := ObjectStatDifferentPropertiesCounter for: [:o | o first] .

	(counter measure: #(#object)) should be: 1.
	(counter measure: #(#object) copy) should be: 0.
	(counter measure: #(#object2)) should be: 1