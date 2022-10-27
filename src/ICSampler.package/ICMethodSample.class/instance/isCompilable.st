query
isCompilable
	
	"Bit 0 = method might be compiled to machine code
	 Bit 1 = method is currently compiled to machine code
	 Bit 2 = is compiled frameless.
	 Bit 3 = method refers to young object.
	 Bit 4 = method too big to be jitted (more than 64k of code, or needs more than 1.5Mb of stack space to compile)
	 Bit 5 = method contains unknown/unjittable bytecode
	 Bit 6 = method should not be jitted because it contains a primitive not to be called from machine code (unused)"
	
	^ xray anyMask: 1