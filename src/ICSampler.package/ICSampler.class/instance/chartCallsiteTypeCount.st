query
chartCallsiteTypeCount

	| c sampleCount totalKindCount |
	sampleCount := self callsiteTypeCount.
	c := RSChart new.
	
	#(monomorphic polymorphic megamorphic) do: [ :kind | | kindCount |
		kindCount := sampleCount collect: [:e| (e at: kind ifAbsent: [ #() ]) size ].
		c addPlot: (RSLinePlot new x: (1 to: kindCount size) y: kindCount).
	].
	totalKindCount := sampleCount collect: [:e| e sum: [ :sub | sub size ] ].
	c addPlot: (RSLinePlot new x: (1 to: totalKindCount size) y: totalKindCount).
	
	"c mustInclude0inY."
	c addDecoration: RSVerticalTick new useNiceLabel.
	c addDecoration: (RSHorizontalTick new numberOfTicks: 30; useDiagonalLabel; yourself).
	^ c build