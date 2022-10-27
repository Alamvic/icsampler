as yet unclassified
sample: aBlock period: aDuration

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
