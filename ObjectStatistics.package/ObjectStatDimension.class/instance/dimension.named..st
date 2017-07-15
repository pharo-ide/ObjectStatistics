accessing
dimension: aDimensionOrBlock named: aString

	| dimension |
	dimension := aDimensionOrBlock asObjectStatDimension.
	dimension name: aString.
	
	subDimensions add: dimension.
	^dimension
	