private
prepareStatistics: anObjectStatistics
	
	super prepareStatistics: anObjectStatistics.
	
	anObjectStatistics addDimension: self copyForSubDimension