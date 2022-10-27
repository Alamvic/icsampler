Class {
	#name : #ICCallsiteInformation,
	#superclass : #Object,
	#instVars : [
		'rawCallsiteInformation',
		'owner'
	],
	#category : #ICSampler
}

{ #category : #testing }
ICCallsiteInformation >> kind [
	
	rawCallsiteInformation size > 3 ifTrue: [ ^ #polymorphic ].
	rawCallsiteInformation second ifNil: [ ^ #megamorphic ].
	^ #monomorphic
]

{ #category : #accessing }
ICCallsiteInformation >> owner: aMethod [

	owner := aMethod
]

{ #category : #accessing }
ICCallsiteInformation >> rawCallsiteInformation: aCollection [ 
	rawCallsiteInformation := aCollection
]
