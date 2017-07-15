initialization
initialize
	super initialize.
	ownerObjects := Set new.
	ownerObjects add: nil.
	shouldCountChildrenInParentMetrics := false