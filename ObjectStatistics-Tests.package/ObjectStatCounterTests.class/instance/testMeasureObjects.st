tests
testMeasureObjects

	| counter |
	counter := ObjectStatCounter new.

	(counter measure: Any) should be: 1.
	(counter measure: Any) should be: 1