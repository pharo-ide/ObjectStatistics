accessing
objectsSpec: valuableOrSpec

	objectsSpec := valuableOrSpec isStateSpec 
		ifTrue: [ valuableOrSpec ] 
		ifFalse: [ SpecOfObjectStateByPredicate from: valuableOrSpec ]