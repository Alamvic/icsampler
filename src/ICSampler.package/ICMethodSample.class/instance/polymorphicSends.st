query
polymorphicSends
	
	^ callSiteInformation select: [ :callSite | self isPolymorphicCallSite: callSite ]