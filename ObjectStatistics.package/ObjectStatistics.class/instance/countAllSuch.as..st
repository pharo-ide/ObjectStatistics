fluent api
countAllSuch: valuableOrSpec as: objectsName
	| metric |
	metric := self countAllAs: objectsName.
	metric objectsSpec: valuableOrSpec