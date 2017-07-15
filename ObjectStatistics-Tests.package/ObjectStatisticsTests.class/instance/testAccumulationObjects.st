tests
testAccumulationObjects

	| stat |
	[:metric1 :metric2 :dimension1 :dimension2 |
		stat := ObjectStatistics new.
		stat metrics: { metric1. metric2 }.
		stat dimensions: { dimension1. dimension2 }.
	
		stat accumulate: #object.

		[ metric1 accumulate: #object.
		metric2 accumulate: #object.
		dimension1 accumulate: #object.
		dimension2 accumulate: #object ] should beDone
	] runWithMocks 