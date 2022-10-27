filtering
onPackage: aPackage

	| package |
	package := aPackage asPackage.
	^ self class new
		  allMethods: allMethods;
		  samples: (samples collect: [ :sample | 
					   sample select: [ :e | e isInPackage: package ] ])