query
callsiteTypeCount

	^ samples collect: [ :sample | 
		  (self sampleCallsiteCount: sample) groupedBy: [ :callsite | 
			  callsite kind ] ]