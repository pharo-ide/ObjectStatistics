tests
testAddingDimensionsForSetOfObjectsByFluentAPI

	| stat dimension subDimension objectsSpec |
	dimension := ObjectStatDimension new.
	subDimension := ObjectStatDimension new.
	objectsSpec := Kind of: Point.
	
	stat := ObjectStatistics new.	
	stat 
		dimension: dimension named: 'dim1';
		for: objectsSpec with: [ 
			stat dimension: subDimension named: 'dim2'].
	
	stat dimensions should haveSize: 1.		
	stat dimensions where first should be: dimension.
	stat dimensions where first subDimensions first should be: subDimension.
	subDimension objectsSpec should be: objectsSpec