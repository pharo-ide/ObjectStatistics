measuring
accumulate: anObject

	| result |
	(objectsSpec matches: anObject) ifFalse: [ ^value ].
	
	result := self measure: anObject.
	
	^value := value + result