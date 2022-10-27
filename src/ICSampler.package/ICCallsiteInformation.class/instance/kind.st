testing
kind
	
	rawCallsiteInformation size > 3 ifTrue: [ ^ #polymorphic ].
	rawCallsiteInformation second ifNil: [ ^ #megamorphic ].
	^ #monomorphic