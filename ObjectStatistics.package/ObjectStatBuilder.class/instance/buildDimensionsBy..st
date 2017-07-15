building
buildDimensionsBy: aBlock

	self buildLastDimension.
	aBlock value.
	self buildPreviousDimension