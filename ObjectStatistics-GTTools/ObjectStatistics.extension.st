Extension { #name : #ObjectStatistics }

{ #category : #'*ObjectStatistics-GTTools' }
ObjectStatistics class >> buildInspectorMetricsTreeIn: composite [
	| tree |
	tree := composite tree
		title: 'Metrics';
		allowsRecursiveSearch: true;
"		shouldExpandToLevel: 0;"

		children: [ :receiver | receiver inspectorTreeItems].
	self expandInspectorTree: tree.
	^tree

]

{ #category : #'*ObjectStatistics-GTTools' }
ObjectStatistics class >> expandInspectorTree: tree [
	tree rootsExpanded.
	tree allExpanded
]

{ #category : #'*ObjectStatistics-GTTools' }
ObjectStatistics >> gtInspectorItemsTreeIn: composite [
	<gtInspectorPresentationOrder: 1>
	
	self class buildInspectorMetricsTreeIn: composite 
]

{ #category : #'*ObjectStatistics-GTTools' }
ObjectStatistics >> inspectorTreeItems [
	dimensions size = 1 ifTrue: [ ^dimensions first inspectorTreeItems ].
	
	^dimensions reject: #isEmpty
]
