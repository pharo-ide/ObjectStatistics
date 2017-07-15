I represent metric which should be calculated over objects set. I accumulate only objects which satisfy my objects spec (which is any object by default).

My subclasses should implement #measure: method which compute metric value for single object.

Public API and Key Messages

- accumulate:  anObject
it measures given object and adds computed result into whole value
- accumulateAll: aCollection
it accumulates all collection items.
- measure: anObject 
it should compute metric on single object
- percentage 
returns percentage of value comparing to parent
- value 
returns currently accumulated value of metric

I am a magnitude which means that different metrics could be compared.

Internal Representation and Key Implementation Points.

    Instance Variables
	name:		<String>
	objectsSpec:		<SpecOfObjectState>
	parent:		<ObjectStatMetric>
	value:		<Number>
