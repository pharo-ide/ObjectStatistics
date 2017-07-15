measuring
accumulate: anObject

	(objectsSpec matches: anObject ) ifFalse: [ ^self ].
	
	self accumulateParentsOf: anObject whichIsLowermostChild: true
