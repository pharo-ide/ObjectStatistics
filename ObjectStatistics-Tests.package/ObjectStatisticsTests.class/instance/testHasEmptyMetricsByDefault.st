tests
testHasEmptyMetricsByDefault

	| stat |
	stat := ObjectStatistics new.
	
	stat where metrics should be isEmpty