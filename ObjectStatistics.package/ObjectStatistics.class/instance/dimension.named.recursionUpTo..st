fluent api
dimension: sliceBlock named: aString recursionUpTo: parentPropertyBlock
	| dimension |
	dimension := ObjectStatRecursiveDimension by: sliceBlock recursion: parentPropertyBlock.
	dimension name: aString.
	dimensionsBuilder addDimension: dimension.	
	^dimension