instance creation
for: anObjectStatistics

	| builder |
	builder := self new.
	builder statistics: anObjectStatistics.
	^builder