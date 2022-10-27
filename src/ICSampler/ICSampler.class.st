Class {
	#name : #ICSampler,
	#superclass : #Object,
	#instVars : [
		'samples',
		'allMethods',
		'gcs'
	],
	#category : 'ICSampler'
}

{ #category : #'ston-core' }
ICSampler class >> stonAllInstVarNames [

	^ super stonAllInstVarNames copyWithout: #( allMethods )
]

{ #category : #query }
ICSampler >> JITCompiledMethods [

	^ samples collect: [ :perMethod | 
		  perMethod select: [ :e | e isJITCompiled ] ]
]

{ #category : #'as yet unclassified' }
ICSampler >> allMethods [
	
	^ allMethods ifNil: [ allMethods := CompiledMethod allInstances ]
]

{ #category : #accessing }
ICSampler >> allMethods: aCollection [ 
	allMethods := aCollection
]

{ #category : #query }
ICSampler >> callsiteTypeCount [

	^ samples collect: [ :sample | 
		  (self sampleCallsiteCount: sample) groupedBy: [ :callsite | 
			  callsite kind ] ]
]

{ #category : #query }
ICSampler >> chartCallsiteTypeCount [

	| c sampleCount totalKindCount |
	sampleCount := self callsiteTypeCount.
	c := RSChart new.
	
	#(monomorphic polymorphic megamorphic) do: [ :kind | | kindCount |
		kindCount := sampleCount collect: [:e| (e at: kind ifAbsent: [ #() ]) size ].
		c addPlot: (RSLinePlot new x: (1 to: kindCount size) y: kindCount).
	].
	totalKindCount := sampleCount collect: [:e| e sum: [ :sub | sub size ] ].
	c addPlot: (RSLinePlot new x: (1 to: totalKindCount size) y: totalKindCount).
	
	"c mustInclude0inY."
	c addDecoration: RSVerticalTick new useNiceLabel.
	c addDecoration: (RSHorizontalTick new numberOfTicks: 30; useDiagonalLabel; yourself).
	^ c build
]

{ #category : #query }
ICSampler >> chartSampleCount [

	| c sampleCount |
	sampleCount := self compiledSampleCount.
	c := RSChart new.
	c addPlot:
		(RSLinePlot new x: (1 to: sampleCount size) y: sampleCount).
	"c mustInclude0inY."
	c addDecoration: RSVerticalTick new useNiceLabel.
	c addDecoration: (RSHorizontalTick new numberOfTicks: 30; useDiagonalLabel; yourself).
	^ c build
]

{ #category : #query }
ICSampler >> compiledSampleCount [

	^ samples collect: [ :perMethod | 
		  perMethod count: [ :e | e isJITCompiled ] ]
]

{ #category : #query }
ICSampler >> compiledSamplePercentage [

	^ samples collect: [ :perMethod | 
		((perMethod count: [ :e | e isJITCompiled ]) / perMethod size * 100)
			asFloat ]
]

{ #category : #'as yet unclassified' }
ICSampler >> initialize [

	super initialize.
	samples := OrderedCollection new
]

{ #category : #filtering }
ICSampler >> onPackage: aPackage [

	| package |
	package := aPackage asPackage.
	^ self class new
		  allMethods: allMethods;
		  samples: (samples collect: [ :sample | 
					   sample select: [ :e | e isInPackage: package ] ])
]

{ #category : #'as yet unclassified' }
ICSampler >> sample [

	| methodSamples |
	methodSamples := Dictionary new.
	self allMethods do: [ :m | 
		methodSamples at: m put: (self sampleMethod: m) ].
	samples add: methodSamples
]

{ #category : #'as yet unclassified' }
ICSampler >> sample: aBlock frequency: aFrequency per: aDuration [

	self sample: aBlock period: (aDuration / aFrequency)
]

{ #category : #'as yet unclassified' }
ICSampler >> sample: aBlock period: aDuration [

	| finished before |
	finished := false.
	"Pre fetch the methods, clean the VM state"
	self allMethods.
	Smalltalk vm voidCogVMState.
	"Run a GC, because the full GC will unlink all callsites, affecting all our measures"
	3 timesRepeat: [Smalltalk garbageCollect].
	
	before := Smalltalk vm fullGCCount.
	
	[ 
	[ finished ] whileFalse: [ 
		self sample.
		aDuration wait ] ] forkAt: Processor activePriority + 1.
	aBlock ensure: [ finished := true].
	
	gcs := Smalltalk vm fullGCCount - before.
	gcs > 0 ifTrue: [ self error: 'Invalid measures due to GC' ].

]

{ #category : #query }
ICSampler >> sampleCallsiteCount: aCollection [

	^ aCollection flatCollect: [ :samplePerMethod | 
		samplePerMethod callsites ]
]

{ #category : #'as yet unclassified' }
ICSampler >> sampleMethod: m [

	^ ICMethodSample new
		method: m;
		xray: m xray;
		callSiteInformation: m callsiteInformation;
		yourself
]

{ #category : #accessing }
ICSampler >> samples: aCollection [ 
	samples := aCollection
]

{ #category : #filtering }
ICSampler >> withInterestingSamplesOnly [

	^ self class new
		  allMethods: allMethods;
		  samples:
			  (samples collect: [ :sample | sample select: [ :e | e notEmpty ] ])
]
