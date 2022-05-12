Extension { #name : #ObjectStatistics }

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatistics class >> buildInspectionMetricsTreeFor: anObject in: aBuilder [
	
	^aBuilder newTree
		roots: { anObject };
		children: [ :receiver | receiver inspectionTreeItems ];
		expandAll;
		yourself
]

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatistics >> inspectionTreeItems [
	dimensions size = 1 ifTrue: [ ^dimensions first inspectionTreeItems ].
	
	^dimensions reject: #isEmpty
]

{ #category : #'*ObjectStatistics-NewTools' }
ObjectStatistics >> itemsTreeInspectionIn: aBuilder [
	<inspectorPresentationOrder: 30 title: 'Metrics'> 
	
	^self class buildInspectionMetricsTreeFor: self in: aBuilder
]
