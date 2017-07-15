measuring
accumulate: anObject exceptingDimension: dimensionName
	
	metrics do: [ :each | each accumulate: anObject ].
	dimensions do: [ :each | 
		each name = dimensionName ifFalse: [ each accumulate: anObject ]]