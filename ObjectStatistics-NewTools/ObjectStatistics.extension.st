Extension { #name : #ObjectStatistics }

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatistics class >> buildInspectionMetricsTreeFor: anObject in: aBuilder [
	
	^aBuilder newTree
		roots: { anObject };
		children: [ :receiver | receiver inspectorTreeItems];
		expandAll;
		yourself
]

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatistics >> itemsTreeInspectionIn: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Metrics'> 
	
	^self class buildInspectionMetricsTreeFor: self in: aBuilder
]
