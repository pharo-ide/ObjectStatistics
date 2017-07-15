tests
testCreationNewMetricForDimension

	| metric actual |
	metric := ObjectStatDifferentPropertiesCounter for: [:o | o first].
	
	actual := metric newForDimension.
	
	actual should beInstanceOf: metric class.
	actual measuredProperties should not be: metric measuredProperties