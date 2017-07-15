tests
testAddingDifferentPropertiesCountMetricForSetOfObjects

	| stat actual objectsSpec |
	stat := ObjectStatistics new.
	objectsSpec := Kind of: Rectangle.
	stat countDifferent: [ :o | o class ] as: 'classes' for: objectsSpec.
	
	actual := stat metrics first.
	actual should beInstanceOf: ObjectStatDifferentPropertiesCounter.
	actual name should equal: 'classes'.
	actual objectsSpec should be: objectsSpec.
	