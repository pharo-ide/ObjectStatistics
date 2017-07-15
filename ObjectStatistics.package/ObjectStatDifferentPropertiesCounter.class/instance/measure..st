measuring
measure: anObject
	| currentSize propertyValue |
	currentSize := measuredProperties size.
	
	propertyValue := propertyBlock value: anObject.
	propertyValue isArray 
		ifTrue: [ measuredProperties addAll: propertyValue ]
		ifFalse: [ measuredProperties add: propertyValue].
	
	^measuredProperties size - currentSize 