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
  ,"integerToLittleEndianBooleanListPaddedRight 4 2"
  ,"takeIntegerFromBooleanList 2 [False,True,False,True,True]"
  ,"takeIntegerFromBooleanListLittleEndian 2 [False,True,False,True,True]"
  ,"integersToBooleanListPadded 2 [2,1,2]"
  ,"integersTolittleEndianBooleanListPadded 2 [2,1,2]"
  ,"booleanListToIntegers 2 [True,False,False,True,True]"
  ,"littleEndianBooleanListToIntegers 2 [True,False,False,True,True]"
 ]