building
for: aStateSpec buildDimensionsBy: aBlock

	| currentObjectsSpec |
	currentObjectsSpec := objectsSpec.
	objectsSpec := aStateSpec.
	self buildDimensionsBy: aBlock.
	objectsSpec := currentObjectsSpec