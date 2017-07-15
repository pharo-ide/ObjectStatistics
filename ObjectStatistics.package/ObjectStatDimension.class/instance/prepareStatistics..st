accessing
prepareStatistics: anObjectStatistics

	subDimensions do: [ :each | 
		anObjectStatistics addDimension: each copyForSubDimension]