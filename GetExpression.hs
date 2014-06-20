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
ghciLinePrompt = "Prelude Music.Instrument.Chord> "

expressions = [
   "integerToBooleanList 12"
  ,"booleanListToInteger [True,True,False,False]"
  ,"integerToBooleanListLittleEndian 12"
  ,"littleEndianBooleanListToInteger [False,False,True,True]"
  ,"padBooleanListLeft 5 [False,True,True]"
  ,"padBooleanListRight 5 [False,True,True]"
  ,"takeIntegerFromBooleanList 2 [False,True,False,True,True]"
  ,"takeIntegerFromBooleanListLittleEndian 2 [False,True,False,True,True]"
  ,"booleanListToIntegers 2 [True,True,False,True,True]"
  ,"integersToBooleanListPadded 2 [3,1,2]"
 ]