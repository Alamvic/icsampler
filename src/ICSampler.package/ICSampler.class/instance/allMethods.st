as yet unclassified
allMethods
	
	^ allMethods ifNil: [ allMethods := CompiledMethod allInstances ]