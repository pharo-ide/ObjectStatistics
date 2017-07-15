examples
exampleTreeProfiler
	| stat prev |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stat countDifferent: [:context | context receiver ] as: 'receivers'.	
		
	stat 
		dimension: [ :context | context receiver class -> context selector] 
		named: 'calls' recursionUpTo: [:context | context sender].
	
	prev := nil.
	thisContext sender 
		runSimulated: [3 printString] 
		contextAtEachStep:	[:current |
			current ~~ prev & (current sender == prev ) ifTrue: [stat accumulate: current].
			prev := current].
			
	^stat inspect