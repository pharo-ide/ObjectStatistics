tests
testAddingDimensionsTreeByFluentAPI

	| stat dimension1 dimension2 dimension3 dimension4 |
	dimension1 := ObjectStatDimension new.
	dimension2 := ObjectStatDimension new.
	dimension3 := ObjectStatDimension new.
	dimension4 := ObjectStatDimension new.
	
	stat := ObjectStatistics new.
	
	stat 
		dimension: dimension1 named: 'dim1';
		with: [ 
			stat 
				dimension: dimension2 named: 'dim2';
				dimension: dimension3 named: 'dim3' ];
		dimension: dimension4 named: 'dim4'.
	
	stat dimensions where first should be: dimension1.
	stat dimensions where last should be: dimension4.
	stat dimensions where first subDimensions first should be: dimension2.
	stat dimensions where first subDimensions last should be: dimension3.