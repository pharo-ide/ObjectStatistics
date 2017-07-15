tests
testAddNewDimension

	| dimension actual stat |
	dimension := Mock new.
	stat := ObjectStatistics new.
	stat addDimension: dimension.
	
	actual := stat dimensions first.
	actual should beReturnedFrom: [ dimension asObjectStatDimension  ].
	actual should receive overallStatistics: stat