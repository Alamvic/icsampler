query
chartSampleCount

	| c sampleCount |
	sampleCount := self compiledSampleCount.
	c := RSChart new.
	c addPlot:
		(RSLinePlot new x: (1 to: sampleCount size) y: sampleCount).
	"c mustInclude0inY."
	c addDecoration: RSVerticalTick new useNiceLabel.
	c addDecoration: (RSHorizontalTick new numberOfTicks: 30; useDiagonalLabel; yourself).
	^ c build