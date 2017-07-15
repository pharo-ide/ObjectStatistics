instance creation
by: slicesBlock recursion: propertyBlock
	^(self by: slicesBlock)
		parentRecursionBlock: propertyBlock 