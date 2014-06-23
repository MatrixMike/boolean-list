Boolean List
=====

Convert integers to boolean lists and visa versa.

Installation (Coming soon...):

```
cabal install boolean-list
```

Example:

```
$ghci

Prelude>:m + Data.BooleanList 

Prelude Data.BooleanList> integerToBooleanList 12
[True,True,False,False]

Prelude Data.BooleanList> booleanListToInteger [True,True,False,False]
12

Prelude Data.BooleanList> integerToBooleanListLittleEndian 12
[False,False,True,True]

Prelude Data.BooleanList> littleEndianBooleanListToInteger [False,False,True,True]
12

Prelude Data.BooleanList> padBooleanListLeft 5 [False,True,True]
[False,False,False,True,True]

Prelude Data.BooleanList> padBooleanListRight 5 [False,True,True]
[False,True,True,False,False]

Prelude Data.BooleanList> integerToBooleanListPadded 4 2
[False,False,True,False]

Prelude Data.BooleanList> integerToLittleEndianBooleanListPadded 4 2
[False,True,False,False]

Prelude Data.BooleanList> takeIntegerFromBooleanList 2 [False,True,False,True,True]
(1,[False,True,True])

Prelude Data.BooleanList> takeIntegerFromBooleanListLittleEndian 2 [False,True,False,True,True]
(2,[False,True,True])

Prelude Data.BooleanList> booleanListToIntegers 2 [True,False,False,True,True]
[2,1,2]

Prelude Data.BooleanList> littleEndianBooleanListToIntegers 2 [True,False,False,True,True]
[1,2,1]

Prelude Data.BooleanList> integersToBooleanListPadded 2 [2,1,2]
[True,False,False,True,True,False]

Prelude Data.BooleanList> integersToLittleEndianBooleanListPadded 2 [2,1,2]
[False,True,True,False,False,True]

Prelude Data.BooleanList> integersToLittleEndianBooleanListPadded 2 [2,1,5]
[False,True,True,False,True,False,True]

Prelude Data.BooleanList> integerToBooleanListLittleEndian 256
[False,False,False,False,False,False,False,False,True]

Prelude Data.BooleanList> bigEndianBooleanListToIntegers 8 [False,False,False,False,False,False,False,False,True]
[0,128]

Prelude Data.BooleanList> integersToBigEndianBooleanListPadded 8 [0,128]
[False,False,False,False,False,False,False,False,True,False,False,False,False,False,False,False]

Prelude Data.BooleanList> integersToLittleEndianBooleanListPadded 8 [256]
[False,False,False,False,False,False,False,False,True]

Prelude Data.BooleanList> booleanListToIntegersTerminated 8 [True,True,True,True,True,True,True,True,True]
[255,191,255]

Prelude Data.BooleanList> integersToBooleanListTerminated 8 [255,191,255]
[True,True,True,True,True,True,True,True,True]

Prelude Data.BooleanList> booleanListToByteString [True,True,True,True,True,True,True,True,True]
"\255\191\255"

Prelude Data.BooleanList> byteStringToBooleanList (Data.ByteString.Char8.pack "\255\191\255")
[True,True,True,True,True,True,True,True,True]
```
