printing
printOn: aStream

	aStream << self value.
	
	name ifNotNil: [ aStream << ' ' << name ].
	
	parent ifNotNil: [ 
		aStream << ' ('.
		self percentage printOn: aStream showingDecimalPlaces: 2.
		aStream << '%)']