Class {
	#name : #ObjectStatMetricTests,
	#superclass : #TestCase,
	#category : 'ObjectStatistics-Tests'
}

{ #category : #tests }
ObjectStatMetricTests >> testCheckForMeaningful [

	| metric parent |
	parent := ObjectStatMetric new.
	metric := ObjectStatMetric new.
	metric parent: parent.
	
	parent value: 10.
	metric should be isMeaningful.
	
	parent value: 0.
	metric should not be isMeaningful.
]

{ #category : #tests }
ObjectStatMetricTests >> testCheckForMeaningfulWhenParentAbsent [

	| metric |
	metric := ObjectStatMetric new.
	metric parent: nil.
	
	metric should be isMeaningful
]

{ #category : #tests }
ObjectStatMetricTests >> testComparisonToAnotherMetric [

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 2.
	
	metric2 := ObjectStatMetric new.
	metric2 value: 3.
	
	metric should be < metric2.
	metric2 should be > metric.
]

{ #category : #tests }
ObjectStatMetricTests >> testComputingPercentWhenNoParent [

	| metric |
	metric := ObjectStatMetric new.
	metric parent: nil.
	metric value: Any.
	
	metric percentage should equal: 100
]

{ #category : #tests }
ObjectStatMetricTests >> testComputingPercentage [

	| metric parentMetric |
	parentMetric := Mock new.
	parentMetric stub value willReturn: 1000.
	metric := ObjectStatMetric new.
	metric parent: parentMetric.
	metric value: 100.
	
	metric percentage should equal: 10
]

{ #category : #tests }
ObjectStatMetricTests >> testConvertingClassToMetric [

	| metric |
	
	metric := ObjectStatMetric asObjectStatMetric.
	
	metric should beInstanceOf: ObjectStatMetric 
]

{ #category : #tests }
ObjectStatMetricTests >> testConvertingToMetric [

	| metric |
	
	metric := ObjectStatMetric new.
	
	metric where asObjectStatMetric should be: metric
]

{ #category : #tests }
ObjectStatMetricTests >> testCreationNewMetricForDimension [

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
]

{ #category : #tests }
ObjectStatMetricTests >> testEqualToAnotherSimilarMetricWithEqualValue [

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 'value1'.
	
	metric2 := ObjectStatMetric new.
	metric2 value: 'value1' copy.
	
	metric should be = metric2
]

{ #category : #tests }
ObjectStatMetricTests >> testEqualToItself [

	| metric |
	metric := ObjectStatMetric new.
	metric value: #value1.
	
	metric should be = metric
]

{ #category : #tests }
ObjectStatMetricTests >> testHasAnyObjectsSpecByDefault [

	| metric |
	metric := ObjectStatMetric new.
	
	(metric objectsSpec == Any) should be: true
]

{ #category : #tests }
ObjectStatMetricTests >> testHasDefaultValueByDefault [

	| metric |
	metric := ObjectStatMetric new.
	
	metric value should be: metric defaultValue
]

{ #category : #tests }
ObjectStatMetricTests >> testNotEqualToAnotherMetricOfDifferentClass [

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 'value1'.
	
	metric2 := Mock new.
	
	metric should not be = metric2
]

{ #category : #tests }
ObjectStatMetricTests >> testNotEqualToAnotherSimilarMetricWithDifferentValue [

	| metric metric2 |
	metric := ObjectStatMetric new.
	metric value: 'value1'.
	
	metric2 := ObjectStatMetric new.
	metric2 value: 'value2'.
	
	metric should not be = metric2
]

{ #category : #tests }
ObjectStatMetricTests >> testPrinting [

	| metric |
	metric := ObjectStatMetric new.
	metric parent: ObjectStatMetric new.
	metric stub percentage willReturn: 10.2356.
	metric value: 1000.
	
	metric printString should equal: '1000 (10.24%)'
]

{ #category : #tests }
ObjectStatMetricTests >> testPrintingWhenNamedExists [

	| metric |
	metric := ObjectStatMetric named: 'test params'.
	metric parent: ObjectStatMetric new.
	metric stub percentage willReturn: 10.2356.
	metric value: 1000.
	
	metric printString should equal: '1000 test params (10.24%)'
]

{ #category : #tests }
ObjectStatMetricTests >> testPrintingWhenNoParent [

	| metric |
	metric := ObjectStatMetric new.
	metric parent: nil.
	metric value: 1000.
	
	metric printString should equal: '1000'
]

{ #category : #tests }
ObjectStatMetricTests >> testResultAccumulation [

	| metric result |
	metric := ObjectStatMetric new.
	(metric stub measure: #object1) willReturn: 10.
	(metric stub measure: #object2) willReturn: 20.
	
	metric accumulate: #object1.
	metric value should be: 10.
	
	result := metric accumulate: #object2.
	metric value should be: 30.
	result should be: 30
]

{ #category : #tests }
ObjectStatMetricTests >> testResultAccumulationForCollectionOfObjects [

	| metric result |
	metric := ObjectStatMetric new.
	(metric stub measure: #object1) willReturn: 10.
	(metric stub measure: #object2) willReturn: 20.
	
	result := metric accumulateAll: #(#object1 #object2).
	
	metric value should be: 30.	
	result should be: 30
]

{ #category : #tests }
ObjectStatMetricTests >> testResultAccumulationShouldSkipObjectsWhichNotMatchesSpec [

	| metric result |
	metric := ObjectStatMetric new.
	metric objectsSpec: [:o | o == #object1].  
	(metric stub measure: #object1) willReturn: 10.
	
	metric accumulate: #object1.
	metric value should be: 10.	
	result := metric accumulate: #object2.
	metric value should be: 10.
	result should be: 10.
	
	metric should not receive measure: #object2
]

{ #category : #tests }
ObjectStatMetricTests >> testSettingObjectsSpec [

	| metric spec |
	
	spec := Kind of: Point.
	metric := ObjectStatMetric new.
	metric objectsSpec: spec.
	
	metric objectsSpec should be: spec
]

{ #category : #tests }
ObjectStatMetricTests >> testSettingObjectsSpecByBlock [

	| metric block |
	
	block := [:n | n even].
	metric := ObjectStatMetric new.
	metric objectsSpec: block.
	
	metric objectsSpec should beInstanceOf: SpecOfObjectStateByPredicate.
	metric objectsSpec predicate should be: block
]

{ #category : #tests }
ObjectStatMetricTests >> testSettingObjectsSpecBySymbol [

	| metric |
	
	metric := ObjectStatMetric new.
	metric objectsSpec: #even.
	
	metric objectsSpec should beInstanceOf: SpecOfObjectStateByPredicate.
	metric objectsSpec predicate should be: #even
]
