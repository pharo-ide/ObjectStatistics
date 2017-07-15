tests
testGettingSortedSlices

	| dimension actual stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'strings'.
	dimension := [:o | o size] asObjectStatDimension.
	dimension overallStatistics: stat.
	
	dimension accumulateAll: #('asd' 'qwe' 'a' 'b' 'c' '1234').
	
	actual := dimension sortedSlices.
	
	actual should haveSize: 3.
	actual where first coordinate should be: 1.
	actual where second coordinate should be: 3.
	actual where last coordinate should be: 4.