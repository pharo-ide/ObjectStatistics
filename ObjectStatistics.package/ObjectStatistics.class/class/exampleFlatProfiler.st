examples
exampleFlatProfiler
	| stat prev |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stat countDifferent: [:context | context receiver ] as: 'receivers'.	

	stat 
		dimension: [ :context | context receiver class ] named: 'classes'; with: [ 
			stat dimension: [ :context | context selector ] named: 'msgs' ];
		dimension: [ :context | context selector ] named: 'msgs'; with: [ 
			stat dimension: [ :context | context receiver class ] named: 'classes' ];
		dimension: [ :context | context receiver class -> context selector ] named: 'leaves';	with: [ 
			stat dimension: [ :context | context sender method ] named: 'sender' ].
	
	prev := nil.
	thisContext sender 
		runSimulated: [3 printString] 
		contextAtEachStep:	[:current |
			current ~~ prev & (current sender == prev ) ifTrue: [stat accumulate: current].
			prev := current].
			
	^stat inspect