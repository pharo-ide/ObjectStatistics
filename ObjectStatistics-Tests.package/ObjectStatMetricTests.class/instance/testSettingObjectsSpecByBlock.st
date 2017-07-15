tests
testSettingObjectsSpecByBlock

	| metric block |
	
	block := [:n | n even].
	metric := ObjectStatMetric new.
	metric objectsSpec: block.
	
	metric objectsSpec should beInstanceOf: SpecOfObjectStateByPredicate.
	metric objectsSpec predicate should be: block