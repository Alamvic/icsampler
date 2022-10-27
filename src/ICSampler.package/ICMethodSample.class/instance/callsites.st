accessing
callsites

	^ callSiteInformation collect: [ :callsite | 
		  ICCallsiteInformation new rawCallsiteInformation: callsite ]