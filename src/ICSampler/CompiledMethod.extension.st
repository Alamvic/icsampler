Extension { #name : #CompiledMethod }

{ #category : #'*ICSampler' }
CompiledMethod class >> fromSton: stonReader [
	| theClass isMeta theClassName map |
	map := stonReader parseMap.
	
	isMeta := map at: #isMeta.
	theClassName := map at: #owner.
	theClass := self environment at: theClassName asSymbol.
	isMeta ifTrue: [ theClass :=  theClass classSide ].
	
	^ theClass >> (map at: #selector) asSymbol
]

{ #category : #'*ICSampler' }
CompiledMethod >> stonOn: stonWriter [

	stonWriter writeObject: self streamMap: [ :dictionary | 
		dictionary
			at: #owner put: self methodClass instanceSide name;
			at: #isMeta put: self methodClass isMeta;
			at: #selector put: self selector ]
]
