Class {
	#name : #ICMethodSample,
	#superclass : #Object,
	#instVars : [
		'method',
		'xray',
		'callSiteInformation'
	],
	#category : #ICSampler
}

{ #category : #accessing }
ICMethodSample >> callSiteInformation [

	^ callSiteInformation
]

{ #category : #accessing }
ICMethodSample >> callSiteInformation: anObject [

	callSiteInformation := anObject
]

{ #category : #accessing }
ICMethodSample >> callsites [

	^ callSiteInformation collect: [ :callsite | 
		  ICCallsiteInformation new rawCallsiteInformation: callsite ]
]

{ #category : #testing }
ICMethodSample >> hasCallsiteInformation [
	
	^ callSiteInformation notEmpty
]

{ #category : #testing }
ICMethodSample >> hasUnlinkedSends [
	
	^ callSiteInformation anySatisfy: [ :callSite | self isUnlinked: callSite ]
]

{ #category : #testing }
ICMethodSample >> isInPackage: aRPackage [ 
	
	^ method methodClass package = aRPackage
]

{ #category : #query }
ICMethodSample >> isJITCompiled [
	
	"Bit 0 = method might be compiled to machine code
	 Bit 1 = method is currently compiled to machine code
	 Bit 2 = is compiled frameless.
	 Bit 3 = method refers to young object.
	 Bit 4 = method too big to be jitted (more than 64k of code, or needs more than 1.5Mb of stack space to compile)
	 Bit 5 = method contains unknown/unjittable bytecode
	 Bit 6 = method should not be jitted because it contains a primitive not to be called from machine code (unused)"
	
	^ xray anyMask: 2r10
]

{ #category : #testing }
ICMethodSample >> isPolymorphicCallSite: aCollection [ 
	
	"Monomorphic and megamorphic have the shape:
	  { bytecode . class . method } or { bytecode . nil . selector }
	Polymorphic sends have the shape
	  { bytecode . class . method ... class . method }
	"
	^ aCollection size > 3
]

{ #category : #testing }
ICMethodSample >> isUnlinked: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
ICMethodSample >> method [

	^ method
]

{ #category : #accessing }
ICMethodSample >> method: anObject [

	method := anObject
]

{ #category : #accessing }
ICMethodSample >> package [
	
	^ method package
]

{ #category : #query }
ICMethodSample >> polymorphicSends [
	
	^ callSiteInformation select: [ :callSite | self isPolymorphicCallSite: callSite ]
]

{ #category : #accessing }
ICMethodSample >> xray [

	^ xray
]

{ #category : #accessing }
ICMethodSample >> xray: anObject [

	xray := anObject
]
