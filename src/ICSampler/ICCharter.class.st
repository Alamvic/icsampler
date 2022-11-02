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
