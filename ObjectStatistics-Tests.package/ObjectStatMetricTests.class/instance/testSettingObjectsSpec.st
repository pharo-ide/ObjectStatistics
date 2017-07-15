tests
testSettingObjectsSpec

	| metric spec |
	
	spec := Kind of: Point.
	metric := ObjectStatMetric new.
	metric objectsSpec: spec.
	
	metric objectsSpec should be: spec