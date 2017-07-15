accessing
newForDimension
	| newMetric |
	newMetric := self copy.
	newMetric prepareForDimensionOf: self.
	
	^newMetric