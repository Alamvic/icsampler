Class {
	#name : #ICSendProfiler,
	#superclass : #Object,
	#category : #ICSampler
}

{ #category : #profiling }
ICSendProfiler >> profileCallsites: aCollection [
	| counters |
	counters := Dictionary new.
	aCollection keysAndValuesDo: [ :arity :callsites | | counter link |
		counters at: arity put: (counter := Counter new).
		link := MetaLink new 
				metaObject: counter;
				selector: #increase.
		callsites do: [ :callsite | callsite astNode link: link ].
	]
	
]
