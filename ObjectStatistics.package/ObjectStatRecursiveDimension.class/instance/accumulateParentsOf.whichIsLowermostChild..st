private
accumulateParentsOf: anObject whichIsLowermostChild: isLowermostChild

	| currentParent sliceForParent slice |
	currentParent := self findParentOf: anObject.
	
	(ownerObjects includes: currentParent) ifTrue: [ 
		slice := self sliceFor: anObject.
		shouldCountChildrenInParentMetrics | isLowermostChild ifTrue: [ 
			slice accumulate: anObject exceptingDimension: name].
		^slice].
	
	sliceForParent := self accumulateParentsOf: currentParent whichIsLowermostChild: false.
	^(sliceForParent dimensionNamed: name) 
		accumulateParentsOf: anObject whichIsLowermostChild: isLowermostChild