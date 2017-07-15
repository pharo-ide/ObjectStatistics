fluent api
countDifferent: propertyBlock as: objectsName for: valuableOrSpec
	| metric |
	metric := self addMetric: (ObjectStatDifferentPropertiesCounter for: propertyBlock) named: objectsName.
	metric objectsSpec: valuableOrSpec.
	^metric