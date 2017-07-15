accessing
sliceFor: anObject

	| slice |
	slice := super sliceFor: anObject.

	(slice dimensionNamed: name) addOwnerObject: anObject.

	^slice	