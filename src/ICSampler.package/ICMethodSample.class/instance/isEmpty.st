query
isEmpty

	^ self isCompilable and: [ 
		self isJITCompiled not ]