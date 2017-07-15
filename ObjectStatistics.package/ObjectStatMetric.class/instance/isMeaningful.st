testing
isMeaningful
	parent ifNil: [ ^true ].
	
	^parent value isZero not