Class {
	#name : #BaselineOfObjectStatistics,
	#superclass : #BaselineOf,
	#category : 'BaselineOfObjectStatistics'
}

{ #category : #baselines }
BaselineOfObjectStatistics >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'StateSpecs' with: [
			spec 
				repository: 'github://dionisiydk/StateSpecs:v4.0.2';
				loads: 'Core' ].
		spec baseline: 'Mocketry' with: [
			spec repository: 'github://dionisiydk/Mocketry:v6.0.3' ].
		spec 
			package: 'ObjectStatistics' with: [spec requires: #('StateSpecs')];
			package: 'ObjectStatistics-Tests' with: [spec requires: #('ObjectStatistics' 'Mocketry')];
			package: 'ObjectStatistics-GTTools' with: [spec requires: #('ObjectStatistics')].
		spec 
			group: 'default' with: #('Core' 'ObjectStatistics-GTTools' 'Tests');
			group: 'Core' with: #('ObjectStatistics');
			group: 'Tests' with: #('ObjectStatistics-Tests') ]

]

{ #category : #accessing }
BaselineOfObjectStatistics >> projectClass [
	^ [ self class environment at: #MetacelloCypressBaselineProject ]
		on: NotFound
		do: [ super projectClass ]
]
