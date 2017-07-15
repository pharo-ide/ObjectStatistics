measuring
accumulate: anObject

	| slice |
	(objectsSpec matches: anObject) ifFalse: [ ^self ].
	
	slice := self sliceFor: anObject.
	
	slice accumulate: anObject