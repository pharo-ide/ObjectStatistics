I am special dimension of object space which unfold separate subdimensions for children of given objects.  I implement this unfolding logic by propagating parents of given objects which I detect by my parentRecursionBlock.

For example I allow implement classic profiler tree statistics where we see number of message sends inside each call in tree view.
Look at my tests ObjectStatRecursiveDimensionTests or profiler example:
	ObjectStatistics exampleTreeProfiler

My ownerObjects is all objects which are folded by same coordinate and all their children together should belongs to me. 

Internal Representation and Key Implementation Points.

    Instance Variables
	ownerObjects		<Set of: <Object>>
	parentRecursionBlock:		<BlockClosure>
	shouldCountChildrenInParentMetrics:		<Boolean>