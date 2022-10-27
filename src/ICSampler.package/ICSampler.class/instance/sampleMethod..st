as yet unclassified
sampleMethod: m

	^ ICMethodSample new
		method: m;
		xray: m xray;
		callSiteInformation: m callsiteInformation;
		yourself