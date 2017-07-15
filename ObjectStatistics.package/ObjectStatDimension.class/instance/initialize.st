initialization
initialize
	super initialize.
	
	slices := Dictionary new.
	subDimensions := OrderedCollection new.
	ignoreMetricNames := Array empty.
	objectsSpec := Any