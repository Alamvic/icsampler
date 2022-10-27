as yet unclassified
sample

	| methodSamples |
	methodSamples := Dictionary new.
	self allMethods do: [ :m | 
		methodSamples at: m put: (self sampleMethod: m) ].
	samples add: methodSamples