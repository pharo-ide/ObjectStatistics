Extension { #name : #ObjectStatSlice }

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatSlice >> itemsTreeInspectionIn: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Metrics'> 
	
	^ObjectStatistics buildInspectionMetricsTreeFor: self in: aBuilder
]
