*ICSampler
fromSton: stonReader
	| theClass isMeta theClassName map |
	map := stonReader parseMap.
	
	isMeta := map at: #isMeta.
	theClassName := map at: #owner.
	theClass := self environment at: theClassName asSymbol.
	isMeta ifTrue: [ theClass :=  theClass classSide ].
	
	^ theClass >> (map at: #selector) asSymbol