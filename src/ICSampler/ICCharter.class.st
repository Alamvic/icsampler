Class {
	#name : #ICCharter,
	#superclass : #Object,
	#category : #ICSampler
}

{ #category : #charting }
ICCharter >> chartCallsites: aCollection [

	| aCollectionByArity callsiteCountByArity c |
	aCollectionByArity := (aCollection associations sorted: [ :a :b | 
		                       a key < b key ]) asOrderedDictionary.
	callsiteCountByArity := aCollectionByArity collect: [ :e | 
		                        e value size ].
	c := RSChart new.
	c addPlot: (RSLinePlot new
			 x: callsiteCountByArity keys
			 y: callsiteCountByArity values).
	c mustInclude0inY.
	c yLog.
	c addDecoration: RSVerticalTick new useNiceLabel.
	c addDecoration: (RSHorizontalTick new
			 numberOfTicks: callsiteCountByArity size;
			 useDiagonalLabel;
			 yourself).
	^ c build
]

{ #category : #charting }
ICCharter >> chartCallsites: aCollection andCountersFrom: aFullBlockClosure [

	| counters countersByArity callsByArity chart totalCallCount |
	counters := ICSendProfiler new
		            profileCallsites: aCollection
		            during: aFullBlockClosure.
	countersByArity := (counters associations sorted: [ :a :b | 
		                    a key < b key ]) asOrderedDictionary.
	totalCallCount := countersByArity values sum: [ :counter | 
		                  counter count ].
	callsByArity := countersByArity collect: [ :e | 
		                (e count / totalCallCount * 100) asFloat ].
	chart := self chartForCallsites: aCollection.
	chart addPlot:
		(RSLinePlot new x: callsByArity keys y: callsByArity values).
	^ chart build
]

{ #category : #charting }
ICCharter >> chartForCallsites: aCollection [

	| aCollectionByArity callsiteCountByArity c totalCallsiteCount |
	aCollectionByArity := (aCollection associations sorted: [ :a :b | 
		                       a key < b key ]) asOrderedDictionary.
	totalCallsiteCount := aCollectionByArity values sum: [ :callsites | callsites size ].
	callsiteCountByArity := aCollectionByArity collect: [ :e | 
		                        (e value size / totalCallsiteCount * 100) asFloat ].
	c := RSChart new.
	c addPlot: (RSLinePlot new
			 x: callsiteCountByArity keys
			 y: callsiteCountByArity values).
	c mustInclude0inY.
	c addDecoration: RSVerticalTick new useNiceLabel.
	c addDecoration: (RSHorizontalTick new
			 numberOfTicks: callsiteCountByArity size;
			 useDiagonalLabel;
			 yourself).
	^ c
]
