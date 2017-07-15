accessing
dimensionNamed: aString
	^dimensions detect: [ :each | each name = aString ]