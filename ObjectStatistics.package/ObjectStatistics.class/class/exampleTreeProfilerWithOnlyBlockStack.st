examples
exampleTreeProfilerWithOnlyBlockStack
	| stat prev block blockContext insideBlock |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stat countDifferent: [:context | context receiver ] as: 'receivers'.	
		
	block := [3.14159 printString].
	stat 
		dimension: [ :context | context receiver class -> context selector] 
		named: 'calls' 
		recursionUpTo: [:context | context sender ifNotNil: [:sender |
				sender closure == block ifTrue: [ nil ] ifFalse: [ sender home]]].
	
	blockContext := nil.
	insideBlock := false.
	prev := nil.
	thisContext
		runSimulated: block
		contextAtEachStep:	[:current |		
			current closure == block ifTrue: [ (blockContext := current). ].
			blockContext ifNotNil: [ 
			current sender == blockContext ifTrue: [ insideBlock := true ].
			current == blockContext sender ifTrue: [ insideBlock := false ]].
			current selector == thisContext selector ifTrue: [ insideBlock := false ].
			insideBlock ifTrue: [
				current ~~ prev & (current sender == prev ) ifTrue: [stat accumulate: current home]].
			prev := current].
			
	^stat inspect