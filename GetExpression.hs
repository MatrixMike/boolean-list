module GetExpression
{-
(getExpression)
-}
where

import Language.Haskell.TH
import Language.Haskell.Meta.Parse.Careful
import Data.Either

getExpression string = head $ rights [parseExp string]
getExpressionAndLine string = (makeGhciLine string,head $ rights [parseExp string])
makeGhciLine x =  ghciLinePrompt ++ x
ghciLinePrompt = "Prelude Data.BooleanList> "

expressions = [
   "integerToBooleanList 12"
  ,"booleanListToInteger [True,True,False,False]"
  ,"integerToBooleanListLittleEndian 12"
  ,"littleEndianBooleanListToInteger [False,False,True,True]"
  ,"padBooleanListLeft 5 [False,True,True]"
  ,"padBooleanListRight 5 [False,True,True]"
  ,"integerToBooleanListPadded 4 2"
  ,"integerToLittleEndianBooleanListPadded 4 2"
  ,"takeIntegerFromBooleanList 2 [False,True,False,True,True]"
  ,"takeIntegerFromBooleanListLittleEndian 2 [False,True,False,True,True]"
  ,"booleanListToIntegers 2 [True,False,False,True,True]"
  ,"littleEndianBooleanListToIntegers 2 [True,False,False,True,True]"
  ,"integersToBooleanListPadded 2 [2,1,2]"
  ,"integersToLittleEndianBooleanListPadded 2 [2,1,2]"
  ,"integersToLittleEndianBooleanListPadded 2 [2,1,5]"
  ,"integerToBooleanListLittleEndian 256"
  ,"bigEndianBooleanListToIntegers 8 [False,False,False,False,False,False,False,False,True]"
  ,"integersToBigEndianBooleanListPadded 8 [0,128]"
  ,"integersToLittleEndianBooleanListPadded 8 [256]"
 ]