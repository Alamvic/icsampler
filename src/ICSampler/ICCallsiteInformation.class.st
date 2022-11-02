Class {
	#name : #ICCallsiteInformation,
	#superclass : #Object,
	#instVars : [
		'rawCallsiteInformation',
		'owner',
		'astNode'
	],
	#category : #ICSampler
}

{ #category : #testing }
ICCallsiteInformation >> arity [
	
	rawCallsiteInformation size > 3 ifTrue: [
		^ rawCallsiteInformation size - 1 / 2 ].
	rawCallsiteInformation second ifNil: [ ^ 7 "more than 6"].
	^ 1
]

{ #category : #accessing }
ICCallsiteInformation >> astNode [

	^ astNode ifNil: [ 
		  astNode := owner sourceNodeForPC: rawCallsiteInformation first.
		  astNode isMessage ifFalse: [ "ignore if not a message send... Slots, FFI methods..." 
			  ^ nil ].
		  astNode ]
]

{ #category : #accessing }
ICCallsiteInformation >> bytecodePC [
	
	^ rawCallsiteInformation first
]

{ #category : #testing }
ICCallsiteInformation >> kind [
	
	rawCallsiteInformation size > 3 ifTrue: [ ^ #polymorphic ].
	rawCallsiteInformation second ifNil: [ ^ #megamorphic ].
	^ #monomorphic
]

{ #category : #accessing }
ICCallsiteInformation >> owner [
	^ owner
]

{ #category : #accessing }
ICCallsiteInformation >> owner: aMethod [

	owner := aMethod
]

{ #category : #query }
ICCallsiteInformation >> percentageOfUniqueEntries [
	
	| allEntries |
	allEntries := rawCallsiteInformation select: [ :e | e isCompiledMethod ].
	^ allEntries asIdentitySet size / allEntries size
]

{ #category : #accessing }
ICCallsiteInformation >> rawCallsiteInformation: aCollection [ 
	rawCallsiteInformation := aCollection
]

{ #category : #resetting }
ICCallsiteInformation >> resetASTNode [
	
	astNode := nil.
	owner := owner methodClass >> owner selector
]
