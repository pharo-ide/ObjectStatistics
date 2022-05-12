Extension { #name : #ObjectStatDimension }

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatDimension >> inspectionTreeItems [
	^self sortedSlices 
]

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatDimension >> itemsTreeInspectionIn: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Metrics'> 
	
	^ObjectStatistics buildInspectionMetricsTreeFor: self in: aBuilder
]
