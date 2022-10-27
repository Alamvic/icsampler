query
JITCompiledMethods

	^ samples collect: [ :perMethod | 
		  perMethod select: [ :e | e isJITCompiled ] ]