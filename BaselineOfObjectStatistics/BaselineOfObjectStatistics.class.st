Class {
	#name : #BaselineOfObjectStatistics,
	#superclass : #BaselineOf,
	#category : #BaselineOfObjectStatistics
}

{ #category : #baselines }
BaselineOfObjectStatistics >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'StateSpecs' with: [
			spec 
				repository: 'github://dionisiydk/StateSpecs:v5.0.1';
				loads: 'Core' ].
		spec baseline: 'Mocketry' with: [
			spec repository: 'github://dionisiydk/Mocketry:v7.0.1' ].
		spec 
			package: 'ObjectStatistics' with: [spec requires: #('StateSpecs')];
			package: 'ObjectStatistics-Tests' with: [spec requires: #('ObjectStatistics' 'Mocketry')];
			package: 'ObjectStatistics-NewTools' with: [spec requires: #('ObjectStatistics')].
		spec 
			group: 'default' with: #('Core' 'ObjectStatistics-NewTools' 'Tests');
			group: 'Core' with: #('ObjectStatistics');
			group: 'Tests' with: #('ObjectStatistics-Tests') ]

]

{ #category : #accessing }
BaselineOfObjectStatistics >> projectClass [
	^ [ self class environment at: #MetacelloCypressBaselineProject ]
		on: NotFound
		do: [ super projectClass ]
]
