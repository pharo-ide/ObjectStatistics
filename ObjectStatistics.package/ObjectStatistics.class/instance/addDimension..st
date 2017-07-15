accessing
addDimension: aDimensionOrBlock

	| dimension |
	dimension := aDimensionOrBlock asObjectStatDimension.
	dimension overallStatistics: self.
	
	dimensions add: dimension.
	^dimension