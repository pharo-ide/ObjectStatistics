fluent api
dimension: aDimensionOrBlock named: aString 
	| dimension |
	dimension := dimensionsBuilder addDimension: aDimensionOrBlock asObjectStatDimension.
	dimension name: aString.
	^dimension