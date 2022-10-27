testing
hasUnlinkedSends
	
	^ callSiteInformation anySatisfy: [ :callSite | self isUnlinked: callSite ]