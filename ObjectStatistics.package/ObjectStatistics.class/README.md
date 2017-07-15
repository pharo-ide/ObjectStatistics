I calculate set of metrics over given objects collection to analyse them from different dimensions.

Imaging that we have collection of message sends and we want to know number of message sends in dimension of receiver, receiver class and message selector. We have different angles to look at this data: from receiver class to selector and receiver or from selector to receiver class and receiver or any other combination. 
We also could analyze different kind of metrics which could be computed on given objects. It could be number of unique receivers, execution time, executed lines of code, etc.

To add object into statistics use accumulation messages: 
- accumulate: anObject
- accumulateAll: aCollection

To declare metrics and dimensions look at "fluent api" protocol: 
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