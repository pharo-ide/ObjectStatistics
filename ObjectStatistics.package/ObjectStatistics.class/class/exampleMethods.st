examples
exampleMethods
	| stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'methods'.
	stat countFunction: [:m | m linesOfCode ] as: 'lines of code'.	
	
	stat 
		dimension: [ :m | m methodClass package name ] named: 'pckgs'; with: [ 
			stat dimension: [ :m | m methodClass ] named: 'classes'; with: [
				stat dimension: [ :m | m selector] named: 'methods']];
		dimension: [ :m | m methodClass package mcWorkingCopy versionInfo author ] named: 'authors'; with: [ 
			stat dimension: [ :m | m methodClass ] named: 'pcks'; with: [
				stat dimension: [ :m | m methodClass ] named: 'classes'; with: [
					stat dimension: [ :m | m selector] named: 'methods']]].

	stat accumulateAll: ((RPackage allInstances 
		select: [ :each | each name beginsWith: 'Athens']) gather: #methods).
	^stat inspect