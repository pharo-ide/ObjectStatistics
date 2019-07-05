Extension { #name : #ObjectStatDimension }

{ #category : #'*ObjectStatistics-GTTools' }
ObjectStatDimension >> gtInspectorItemsTreeIn: composite [
	<gtInspectorPresentationOrder: 1>
	ObjectStatistics buildInspectorMetricsTreeIn: composite 
]

{ #category : #'*ObjectStatistics-GTTools' }
ObjectStatDimension >> inspectorTreeItems [
	^self sortedSlices 
]
