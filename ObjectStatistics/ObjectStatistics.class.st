"
I calculate set of metrics over given objects collection to analyse them from different dimensions.

Imaging that we have collection of message sends and we want to know number of message sends in dimension of receiver, receiver class and message selector. We have different angles to look at this data: from receiver class to selector and receiver or from selector to receiver class and receiver or any other combination. 
We also could analyze different kind of metrics which could be computed on given objects. It could be number of unique receivers, execution time, executed lines of code, etc.

To add object into statistics use accumulation messages: 
- accumulate: anObject
- accumulateAll: aCollection

To declare metrics and dimensions look at ""fluent api"" protocol: 
- countAllAs: 'objects'
it adds simple objects count metric.

- countAllSuch: [ o: | true ] as: 'special objects'
it adds count metric for all objects which satisfy given spec

- countDifferent: [ :o | o property ] as: 'properties'
it will count number of different properties over full objects set

- countDifferent: [ :point | point x ] as: 'properties' for: (Kind of: Point)
it will measure only Point instances for count of different x coordinate.

- countFunction: [ :rectangle | rectangle area ] as: 'area'
it will calculate sumary area of given rectangles set.

- dimention: [ :o | o class ] as: 'classes'
it adds dimention of classes (in this case) into statistics which will calculate all metrics for every class of given objects set.

To define hierarchy of dimensions there is two messages:
- with: dimensionsDefinitionBlock
All dimensions inside block will be added into previously defined dimension. For example:

	stat 
		dimension: [ :o | o class package] as: 'packages';
		with: [ 
			 stat dimension: [ :o | o class ] as: 'classes']

- for: [:o | o > 10|] with: dimensionsDefinitionBlock
It is same #with: message. But it will add sub dimensions only for objects which satisfy given spec

In the level of subdimensions some of metrics could be not needed. They can be disabled by:
	stat ignoreMetrics: #('classes')

Look at class side examples to play in live.	 

Internal Representation and Key Implementation Points.

    Instance Variables
	dimensions:		<OrderedCollection of: <ObjectStatDimension>>
	dimensionsBuilder:		<ObjectStatBuilder>
	metrics:		<OrderedCollection of: <ObjectStatMetric>>
"
Class {
	#name : #ObjectStatistics,
	#superclass : #Object,
	#instVars : [
		'metrics',
		'dimensions',
		'dimensionsBuilder'
	],
	#category : 'ObjectStatistics'
}

{ #category : #examples }
ObjectStatistics class >> exampleFlatProfiler [
	| stat prev |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stat countDifferent: [:context | context receiver ] as: 'receivers'.	

	stat 
		dimension: [ :context | context receiver class ] named: 'classes'; with: [ 
			stat dimension: [ :context | context selector ] named: 'msgs' ];
		dimension: [ :context | context selector ] named: 'msgs'; with: [ 
			stat dimension: [ :context | context receiver class ] named: 'classes' ];
		dimension: [ :context | context receiver class -> context selector ] named: 'leaves';	with: [ 
			stat dimension: [ :context | context sender method ] named: 'sender' ].
	
	prev := nil.
	thisContext sender 
		runSimulated: [3 printString] 
		contextAtEachStep:	[:current |
			current ~~ prev & (current sender == prev ) ifTrue: [stat accumulate: current].
			prev := current].
			
	^stat inspect
]

{ #category : #examples }
ObjectStatistics class >> exampleMethods [
	| stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'methods'.
	stat countFunction: [:m | m linesOfCode ] as: 'lines of code'.	
	
	stat 
		dimension: [ :m | m methodClass package name ] named: 'pckgs'; with: [ 
			stat dimension: [ :m | m methodClass ] named: 'classes'; with: [
				stat dimension: [ :m | m selector] named: 'methods']];
		dimension: [ :m | m methodClass package mcWorkingCopy versionInfo author ] named: 'authors'; with: [ 
			stat dimension: [ :m | m methodClass ] named: 'pcks'; with: [
				stat dimension: [ :m | m methodClass ] named: 'classes'; with: [
					stat dimension: [ :m | m selector] named: 'methods']]].

	stat accumulateAll: ((RPackage allInstances 
		select: [ :each | each name beginsWith: 'Athens']) gather: #methods).
	^stat inspect
]

{ #category : #examples }
ObjectStatistics class >> exampleStringsWithSingleDimension [
	| stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'strs'.
	stat countFunction: [:s | s count: #isVowel] as: 'vowels'.	
	
	stat dimension: [ :s | s size ] named: 'size'.
	
	stat accumulateAll: ByteSymbol allInstances.
	^stat inspect
]

{ #category : #examples }
ObjectStatistics class >> exampleStringsWithTwoDimensions [
	| stat |
	stat := ObjectStatistics new.
	stat countAllAs: 'strs'.
	stat countFunction: [:s | s count: #isVowel] as: 'vowels'.	
	
	stat dimension: [ :s | s ifEmpty: [ #empty ] ifNotEmpty: [ s first] ] named: 'first char'.
	stat dimension: [ :s | s size ] named: 'sizes'.
		
	stat accumulateAll: ByteSymbol allInstances.
	^stat inspect
]

{ #category : #examples }
ObjectStatistics class >> exampleTreeProfiler [
	| stat prev |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stat countDifferent: [:context | context receiver ] as: 'receivers'.	
		
	stat 
		dimension: [ :context | context receiver class -> context selector] 
		named: 'calls' recursionUpTo: [:context | context sender].
	
	prev := nil.
	thisContext sender 
		runSimulated: [3 printString] 
		contextAtEachStep:	[:current |
			current ~~ prev & (current sender == prev ) ifTrue: [stat accumulate: current].
			prev := current].
			
	^stat inspect
]

{ #category : #examples }
ObjectStatistics class >> exampleTreeProfilerWithOnlyBlockStack [
	| stat prev block blockContext insideBlock |
	stat := ObjectStatistics new.
	stat countAllAs: 'sends'.
	stat countDifferent: [:context | context receiver ] as: 'receivers'.	
		
	block := [3.14159 printString].
	stat 
		dimension: [ :context | context receiver class -> context selector] 
		named: 'calls' 
		recursionUpTo: [:context | context sender ifNotNil: [:sender |
				sender closure == block ifTrue: [ nil ] ifFalse: [ sender home]]].
	
	blockContext := nil.
	insideBlock := false.
	prev := nil.
	thisContext
		runSimulated: block
		contextAtEachStep:	[:current |		
			current closure == block ifTrue: [ (blockContext := current). ].
			blockContext ifNotNil: [ 
			current sender == blockContext ifTrue: [ insideBlock := true ].
			current == blockContext sender ifTrue: [ insideBlock := false ]].
			current selector == thisContext selector ifTrue: [ insideBlock := false ].
			insideBlock ifTrue: [
				current ~~ prev & (current sender == prev ) ifTrue: [stat accumulate: current home]].
			prev := current].
			
	^stat inspect
]

{ #category : #measuring }
ObjectStatistics >> accumulate: anObject [
	
	metrics do: [ :each | each accumulate: anObject ].
	dimensions do: [ :each | each accumulate: anObject ]
]

{ #category : #measuring }
ObjectStatistics >> accumulate: anObject exceptingDimension: dimensionName [
	
	metrics do: [ :each | each accumulate: anObject ].
	dimensions do: [ :each | 
		each name = dimensionName ifFalse: [ each accumulate: anObject ]]
]

{ #category : #measuring }
ObjectStatistics >> accumulateAll: aCollection [
	
	aCollection do: [ :each | self accumulate: each ]
]

{ #category : #accessing }
ObjectStatistics >> addDimension: aDimensionOrBlock [

	| dimension |
	dimension := aDimensionOrBlock asObjectStatDimension.
	dimension overallStatistics: self.
	
	dimensions add: dimension.
	^dimension
]

{ #category : #accessing }
ObjectStatistics >> addMetric: metricSource [
	| metric |
	metric := metricSource asObjectStatMetric.
	 
	metrics add: metric.
	
	^metric
]

{ #category : #accessing }
ObjectStatistics >> addMetric: metricSource named: aString [ 
	| metric |
	metric := self addMetric: metricSource.
	metric name: aString.
	^metric
]

{ #category : #'fluent api' }
ObjectStatistics >> countAllAs: objectsName [
	^self addMetric: ObjectStatCounter named: objectsName
]

{ #category : #'fluent api' }
ObjectStatistics >> countAllSuch: valuableOrSpec as: objectsName [
	| metric |
	metric := self countAllAs: objectsName.
	metric objectsSpec: valuableOrSpec
]

{ #category : #'fluent api' }
ObjectStatistics >> countDifferent: propertyBlock as: objectsName [
	self addMetric: (ObjectStatDifferentPropertiesCounter for: propertyBlock) named: objectsName
]

{ #category : #'fluent api' }
ObjectStatistics >> countDifferent: propertyBlock as: objectsName for: valuableOrSpec [
	| metric |
	metric := self addMetric: (ObjectStatDifferentPropertiesCounter for: propertyBlock) named: objectsName.
	metric objectsSpec: valuableOrSpec.
	^metric
]

{ #category : #'fluent api' }
ObjectStatistics >> countFunction: functionBlock as: objectsName [
	self addMetric: functionBlock named: objectsName
]

{ #category : #'fluent api' }
ObjectStatistics >> dimension: aDimensionOrBlock named: aString [ 
	| dimension |
	dimension := dimensionsBuilder addDimension: aDimensionOrBlock asObjectStatDimension.
	dimension name: aString.
	^dimension
]

{ #category : #'fluent api' }
ObjectStatistics >> dimension: sliceBlock named: aString recursionUpTo: parentPropertyBlock [
	| dimension |
	dimension := ObjectStatRecursiveDimension by: sliceBlock recursion: parentPropertyBlock.
	dimension name: aString.
	dimensionsBuilder addDimension: dimension.	
	^dimension
]

{ #category : #accessing }
ObjectStatistics >> dimensionNamed: aString [
	^dimensions detect: [ :each | each name = aString ]
]

{ #category : #accessing }
ObjectStatistics >> dimensions [
	^ dimensions
]

{ #category : #accessing }
ObjectStatistics >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #'fluent api' }
ObjectStatistics >> for: aStateSpec with: dimensionsCreationBlock [

	dimensionsBuilder for: aStateSpec buildDimensionsBy: dimensionsCreationBlock
]

{ #category : #testing }
ObjectStatistics >> hasDimensions [
	^dimensions notEmpty 
]

{ #category : #'fluent api' }
ObjectStatistics >> ignoreMetrics: metricNames [
	dimensionsBuilder ignoreMetrics: metricNames
]

{ #category : #initialization }
ObjectStatistics >> initialize [
	super initialize.
	
	metrics := OrderedCollection new.
	dimensions := OrderedCollection new.
	dimensionsBuilder := ObjectStatBuilder for: self
]

{ #category : #accessing }
ObjectStatistics >> lastDimension [
	^dimensions last
]

{ #category : #accessing }
ObjectStatistics >> mainMetric [
	^metrics first
]

{ #category : #accessing }
ObjectStatistics >> metrics [
	^ metrics
]

{ #category : #accessing }
ObjectStatistics >> metrics: anObject [
	metrics := anObject
]

{ #category : #accessing }
ObjectStatistics >> newForDimension: anObjectStatDimension [ 
	| newStat newMetrics |
	newStat := self class new.
	newMetrics := metrics 
		reject: [ :each | anObjectStatDimension isIgnoreMetric: each] 
		thenCollect: [ :each | each newForDimension ].
	newStat metrics: newMetrics.
	anObjectStatDimension prepareStatistics: newStat.
	^newStat
]

{ #category : #accessing }
ObjectStatistics >> objectsSpec [
	^Any
]

{ #category : #printing }
ObjectStatistics >> printMetricsOn: aStream [

	metrics ifEmpty: [ ^self ].
	
	metrics first printOn: aStream.
	metrics allButFirstDo: [ :each | 
		each isMeaningful ifTrue: [ 
			aStream << ', '.
			each printOn: aStream]]
]

{ #category : #printing }
ObjectStatistics >> printOn: aStream [
	super printOn: aStream.
	
	aStream << '('.
	self printMetricsOn: aStream.
	aStream << ')'.
]

{ #category : #'fluent api' }
ObjectStatistics >> with: dimensionsCreationBlock [
	
	dimensionsBuilder buildDimensionsBy: dimensionsCreationBlock
]
