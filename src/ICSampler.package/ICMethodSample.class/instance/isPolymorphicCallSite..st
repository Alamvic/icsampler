testing
isPolymorphicCallSite: aCollection 
	
	"Monomorphic and megamorphic have the shape:
	  { bytecode . class . method } or { bytecode . nil . selector }
	Polymorphic sends have the shape
	  { bytecode . class . method ... class . method }
	"
	^ aCollection size > 3