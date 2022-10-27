query
compiledSamplePercentage

	^ samples collect: [ :perMethod | 
		((perMethod count: [ :e | e isJITCompiled ]) / perMethod size * 100)
			asFloat ]