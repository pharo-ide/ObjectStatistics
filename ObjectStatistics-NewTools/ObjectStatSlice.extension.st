Extension { #name : #ObjectStatSlice }

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatSlice >> inspectionTreeItems [
	^statistics inspectionTreeItems
]

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatSlice >> itemsTreeInspectionIn: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Metrics'> 
	
	^ObjectStatistics buildInspectionMetricsTreeFor: self in: aBuilder
]
