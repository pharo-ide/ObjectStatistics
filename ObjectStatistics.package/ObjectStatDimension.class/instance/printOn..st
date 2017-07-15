printing
printOn: aStream
	name ifNil: [ ^super printOn: aStream ].
	
	aStream << slices size << ' ' << name