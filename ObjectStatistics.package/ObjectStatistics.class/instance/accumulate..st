measuring
accumulate: anObject
	
	metrics do: [ :each | each accumulate: anObject ].
	dimensions do: [ :each | each accumulate: anObject ]