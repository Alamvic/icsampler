query
compiledSampleCount

	^ samples collect: [ :perMethod | 
		  perMethod count: [ :e | e isJITCompiled ] ]