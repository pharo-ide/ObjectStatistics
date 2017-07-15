tests
testAccumulationAllObjects

	| stat |
	[:metric1 :metric2 |
		stat := ObjectStatistics new.
		stat metrics: { metric1. metric2 }.
	
		stat accumulateAll: #(#object1 #object2).

		[ metric1 accumulate: #object1.
		metric2 accumulate: #object1.
		metric1 accumulate: #object2.
		metric2 accumulate: #object2 ] should beDone
	] runWithMocks 