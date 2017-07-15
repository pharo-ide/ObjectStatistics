tests
testShouldNotCountChildrenInParentMetricsByDefault

	| dimension |
	dimension := ObjectStatRecursiveDimension new.
			
	dimension should not be shouldCountChildrenInParentMetrics 