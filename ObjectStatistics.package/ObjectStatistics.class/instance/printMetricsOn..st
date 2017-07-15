printing
printMetricsOn: aStream

	metrics ifEmpty: [ ^self ].
	
	metrics first printOn: aStream.
	metrics allButFirstDo: [ :each | 
		each isMeaningful ifTrue: [ 
			aStream << ', '.
			each printOn: aStream]]