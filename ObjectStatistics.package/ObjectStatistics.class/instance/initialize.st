initialization
initialize
	super initialize.
	
	metrics := OrderedCollection new.
	dimensions := OrderedCollection new.
	dimensionsBuilder := ObjectStatBuilder for: self