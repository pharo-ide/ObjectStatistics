tests
testPreparingStatistics

	| dimension |
	[:subDimension1 :subDimension2 :stat |
		dimension := ObjectStatDimension new.
		dimension subDimensions: { subDimension1. subDimension2 }.
		subDimension1 stub copyForSubDimension willReturn: #newDim1.
		subDimension2 stub copyForSubDimension willReturn: #newDim2.
		
		dimension prepareStatistics: stat.
		
		stat should receive addDimension: #newDim1.
		stat should receive addDimension: #newDim2.	
	 ] runWithMocks 