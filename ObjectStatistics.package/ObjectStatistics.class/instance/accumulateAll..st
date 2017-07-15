measuring
accumulateAll: aCollection
	
	aCollection do: [ :each | self accumulate: each ]