Class {
	#name : #ICSendProfiler,
	#superclass : #Object,
	#category : #ICSampler
}

{ #category : #profiling }
ICSendProfiler >> profileCallsites: aCollection [

	| counters links |
	counters := Dictionary new.
	links := OrderedCollection new.
	[ 
	aCollection keysAndValuesDo: [ :arity :callsites | 
		| counter link |
		counters at: arity put: (counter := Counter new).
		link := MetaLink new
			        metaObject: counter;
			        selector: #increment.
		links add: link.
		callsites do: [ :callsite | 
			callsite astNode ifNotNil: [ :node | node link: link ] ] ] ] 
		ensure: [ links do: #uninstall ].
	^ counters
]

{ #category : #profiling }
ICSendProfiler >> profileCallsites: aCollection during: aBlock [

	| counters links |
	counters := Dictionary new.
	links := OrderedCollection new.
	[ 
	aCollection keysAndValuesDo: [ :arity :callsites | 
		| counter link |
		counters at: arity put: (counter := Counter new).
		link := MetaLink new
			        metaObject: counter;
			        selector: #increment.
		links add: link.
		callsites do: [ :callsite | 
			callsite astNode ifNotNil: [ :node | 
				node link: link ] ] ].
	aBlock value ] ensure: [ links do: #uninstall ].
	^ counters
]
