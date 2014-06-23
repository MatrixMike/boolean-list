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

Prelude Data.BooleanList> padBooleanList 5 [False,True,True]
[False,False,False,True,True]

Prelude Data.BooleanList> integerToBooleanListPadded 4 2
[False,False,True,False]

Prelude Data.BooleanList> takeIntegerFromBooleanList 2 [False,True,False,True,True]
(1,[False,True,True])

Prelude Data.BooleanList> booleanListToIntegers 2 [True,False,False,True,True]
[2,1,2]

Prelude Data.BooleanList> integersToBooleanListPadded 2 [2,1,2]
[True,False,False,True,True,False]

Prelude Data.BooleanList> booleanListToByteString [True,True,True,True,True,True,True,True,True]
"\255\191\255"

Prelude Data.BooleanList> byteStringToBooleanList (Data.ByteString.Char8.pack "\255\191\255")
[True,True,True,True,True,True,True,True,True]
```
