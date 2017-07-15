*ObjectStatistics-GTTools
inspectorTreeItems
	dimensions size = 1 ifTrue: [ ^dimensions first inspectorTreeItems ].
	
	^dimensions reject: #isEmpty