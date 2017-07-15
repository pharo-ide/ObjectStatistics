examples
exampleStringsWithSingleDimension
	| stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'strs'.
	stat countFunction: [:s | s count: #isVowel] as: 'vowels'.	
	
	stat dimension: [ :s | s size ] named: 'size'.
	
	stat accumulateAll: ByteSymbol allInstances.
	^stat inspect