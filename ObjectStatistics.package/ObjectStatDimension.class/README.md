I represent dimension in space of objects.
You can think about me as dimension of object classes, dimension of object packages and etc.

During statistics accumulation I receive measured objects. For every object I retrive concrete coordinate in object space. It calculated by my coordinatesBlock. In this coordinate I create new statistics and add given object into it.  Coordinate value and statistics are incapsulated in ObjectStatSlice instance. At the end of objects analysis I contain set of slices where each slice includes own statistics in particular dimension coordinate.

I have own sub dimensions which play same role as dimensions inside statistics. Each statistics in my slices will include my sub dimensions.
It allows to define hierarchy of dimension for statistics analysis.

I have also objectsSpec which specified set of objects which could be accumulated by me. It allows to define dimensions for subset of objects space.

For more information look at ObjectStatistics comment.

Public API and Key Messages

- accumulate: anObject
it adds given object into statistics which defined for corresponding coordinate in objects space

- accumulateAll: aCollection
it accumulates all collection items
 
Internal Representation and Key Implementation Points.

    Instance Variables
	ignoreMetricNames:		<Array of: <String>>
	name:		<String>
	objectsSpec:		<SpecOfObjectState>
	overallStatistics:		<ObjectStatistics>
	slices:		<Dictionary of: <ObjectStatSlice>>
	coordinatesBlock:		<BlockClosure>
	subDimensions:		<OrderedCollection of: <ObjectStatDimension>>