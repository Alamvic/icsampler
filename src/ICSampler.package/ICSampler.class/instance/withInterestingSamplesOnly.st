filtering
withInterestingSamplesOnly

	^ self class new
		  allMethods: allMethods;
		  samples:
			  (samples collect: [ :sample | sample select: [ :e | e notEmpty ] ])