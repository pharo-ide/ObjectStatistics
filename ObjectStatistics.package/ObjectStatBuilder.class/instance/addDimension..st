accessing
addDimension: anObjectStatDimension
	| dimension |
	dimension := self currentDimension addDimension: anObjectStatDimension. 
	dimension objectsSpec: objectsSpec.
	^dimension