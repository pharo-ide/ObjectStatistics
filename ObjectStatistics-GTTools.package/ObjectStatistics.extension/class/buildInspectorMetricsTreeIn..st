*ObjectStatistics-GTTools
buildInspectorMetricsTreeIn: composite
	| tree |
	tree := composite tree
		title: 'Metrics';
		allowsRecursiveSearch: true;
"		shouldExpandToLevel: 0;"

		children: [ :receiver | receiver inspectorTreeItems].
	self expandInspectorTree: tree.
	^tree
