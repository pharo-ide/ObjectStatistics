tests
testSettingObjectsSpecBySymbol

	| metric |
	
	metric := ObjectStatMetric new.
	metric objectsSpec: #even.
	
	metric objectsSpec should beInstanceOf: SpecOfObjectStateByPredicate.
	metric objectsSpec predicate should be: #even