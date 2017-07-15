tests
testHasAnyObjectsSpecByDefault

	| dimension |
	dimension := ObjectStatDimension new.
	
	(dimension objectsSpec == Any) should be: true