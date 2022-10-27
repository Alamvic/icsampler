# ICSampler: Inline Cache Sampling Tool

## Preparation/Installation

1. Launch the image with large code size and a large eden size to avoid code compactions and garbage collections.
They add noise to the measurements.

```bash
$ vm --codeSize=20M --edenSize=100M Pharo.image --interactive
```

2. Load the code using Iceberg
3. Tune the GC to minimize noise

```smalltalk
Metacello new
	baseline: 'VMTunning';
	repository: 'github://pharo-project/pharo-vm-tunning';
	load.
	
GCConfiguration readFromVM
	growthHeadroom: 100 * 1024 * 1024;
   fullGCRatio: 1;
	shrinkThreadshold: 1024;
   writeToVM.
```

## Usage

```smalltalk
ICSampler new
	sample: [ 'Microdown-Tests' asPackage testSuite run ]
	period: 20 milliSeconds.

ICSampler new
	sample: [ 
		'Roassal3-Global-Tests' asPackage testSuite run.
		'Roassal3-Global-Tests' asPackage testSuite run ]
	period: 200 milliSeconds.
```

## Inspecting the results

The  `ICSampler` class contains several useful methods for querying and plotting.
- `chartSampleCount` plots the number of methods that are JIT compiled per sample
<img width="704" alt="imagen" src="https://user-images.githubusercontent.com/708322/198389208-0e04b494-d1a0-4139-9640-82cafd8cc775.png">

- `chartCallsiteTypeCount` charts the the number of mono/poly/mega-morphic callsits per sample
<img width="676" alt="imagen" src="https://user-images.githubusercontent.com/708322/198389253-ecee5197-c13a-4690-9ef5-66d6bb155968.png">

Other useful methods are in the `query` protocol.
