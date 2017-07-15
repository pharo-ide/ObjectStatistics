tests
testAddingRecursiveDimension

	| stat dimension |
	stat := ObjectStatistics new.	
	stat dimension: #coordinatesBlock named: 'dim1' recursionUpTo: #parentPropertyBlock.
	
	stat dimensions should haveSize: 1.		
	dimension := stat dimensions first.
	dimension should beInstanceOf: ObjectStatRecursiveDimension.
	dimension coordinatesBlock should be: #coordinatesBlock.
	dimension parentRecursionBlock should be: #parentPropertyBlock.
	dimension name should equal: 'dim1'