fluent api
countDifferent: propertyBlock as: objectsName
	self addMetric: (ObjectStatDifferentPropertiesCounter for: propertyBlock) named: objectsName