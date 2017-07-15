accessing
copyForSubDimension 
	| copy |
	copy := super copyForSubDimension.
	copy ownerObjects: Set new.
	^copy