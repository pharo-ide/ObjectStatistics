accessing
percentage

	parent ifNil: [ ^100 ].
	parent value isZero ifTrue: [ ^0 ].
	
	^value * 100 / parent value 