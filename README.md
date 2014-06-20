Boolean List
=====

Convert integers to their shortest binary digit sequences.

Installation:

```
cabal install boolean-list
```

Example:

```
$ghci

Prelude>:m + Data.BooleanList 

Prelude Music.Instrument.Chord> integerToBooleanList 12
[True,True,False,False]

Prelude Music.Instrument.Chord> booleanListToInteger [True,True,False,False]
12

Prelude Music.Instrument.Chord> integerToBooleanListLittleEndian 12
[False,False,True,True]

Prelude Music.Instrument.Chord> littleEndianBooleanListToInteger [False,False,True,True]
12

Prelude Music.Instrument.Chord> padBooleanListLeft 5 [False,True,True]
[False,False,False,True,True]

Prelude Music.Instrument.Chord> padBooleanListRight 5 [False,True,True]
[False,True,True,False,False]

Prelude Music.Instrument.Chord> takeIntegerFromBooleanList 2 [False,True,False,True,True]
(1,[False,True,True])

Prelude Music.Instrument.Chord> takeIntegerFromBooleanListLittleEndian 2 [False,True,False,True,True]
(2,[False,True,True])

Prelude Music.Instrument.Chord> booleanListToIntegers 2 [True,True,False,True,True]
[3,1,2]

Prelude Music.Instrument.Chord> integersToBooleanListPadded 2 [3,1,2]
[True,True,False,True,True,False]
```
