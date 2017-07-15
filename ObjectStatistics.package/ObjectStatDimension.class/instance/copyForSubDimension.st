accessing
copyForSubDimension

	| copy |
	copy := self copy.
	copy slices: Dictionary new.
	^copy