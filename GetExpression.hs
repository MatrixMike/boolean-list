{-# OPTIONS_GHC -fwarn-missing-signatures #-}

module GetExpression where

import Data.Either
--import Language.Haskell.Meta.Parse.Careful
import Language.Haskell.TH

getExpression string = head $ rights [parseExp string]

getExpressionAndLine string =
  (makeGhciLine string, head $ rights [parseExp string])

makeGhciLine x = ghciLinePrompt ++ x

ghciLinePrompt = "Prelude Data.BooleanList> "

expressions =
  [ "integerToBooleanList 12"
  , "booleanListToInteger [True,True,False,False]"
  , "integerToBooleanListLittleEndian 12"
  , "littleEndianBooleanListToInteger [False,False,True,True]"
  , "padBooleanList 5 [False,True,True]"
  , "integerToBooleanListPadded 4 2"
  , "takeIntegerFromBooleanList 2 [False,True,False,True,True]"
  , "booleanListToIntegers 2 [True,False,False,True,True]"
  , "integersToBooleanListPadded 2 [2,1,2]"
  , "booleanListToByteString [True,True,True,True,True,True,True,True,True]"
  , "byteStringToBooleanList (Data.ByteString.Char8.pack \"\\255\\191\\255\")"
  , "maximumIntegerForBools 7"
  , "boolsRequiredForInteger 255"
  ]
