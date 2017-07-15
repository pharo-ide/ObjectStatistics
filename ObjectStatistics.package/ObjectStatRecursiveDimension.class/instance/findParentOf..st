private
findParentOf: anObject

	| parent |
	parent := parentRecursionBlock value: anObject.
	
	[objectsSpec matches: parent] whileFalse: [
		parent := parentRecursionBlock value: parent].	

	^parent