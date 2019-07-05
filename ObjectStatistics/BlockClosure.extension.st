Extension { #name : #BlockClosure }

{ #category : #'*ObjectStatistics' }
BlockClosure >> asObjectStatDimension [
	^ObjectStatDimension by: self
]

{ #category : #'*ObjectStatistics' }
BlockClosure >> asObjectStatMetric [
	^ObjectStatFunctionMetric by: self
]
