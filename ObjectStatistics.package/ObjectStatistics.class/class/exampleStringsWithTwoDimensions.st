examples
exampleStringsWithTwoDimensions
	| stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'strs'.
	stat countFunction: [:s | s count: #isVowel] as: 'vowels'.	
	
	stat dimension: [ :s | s ifEmpty: [ #empty ] ifNotEmpty: [ s first] ] named: 'first char'.
	stat dimension: [ :s | s size ] named: 'sizes'.
		
	stat accumulateAll: ByteSymbol allInstances.
	^stat inspect