tests
testCreationNewMetricForDimension

	| metric actual objectsSpec |
	objectsSpec := Kind of: Point.
	metric := ObjectStatMetric named: 'test metric'.
	metric objectsSpec: objectsSpec.

	actual := metric newForDimension.
	
	actual should beInstanceOf: metric class.
	actual name should equal: 'test metric'.
	actual parent should be: metric.
	actual value should be: metric defaultValue.
	actual objectsSpec should be: objectsSpec