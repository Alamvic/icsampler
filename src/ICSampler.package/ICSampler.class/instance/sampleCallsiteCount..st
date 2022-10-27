query
sampleCallsiteCount: aCollection

	^ aCollection flatCollect: [ :samplePerMethod | 
		samplePerMethod callsites ]