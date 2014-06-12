import Data.BooleanList
import Test.HUnit

makeCase x y = TestCase (assertEqual "" x y)

main = runTestTT $ TestList [
     makeCase (integerToBooleanList 12) [True,True,False,False]
    ,makeCase (booleanListToInteger [True,True,False,False]) 12
    ,makeCase (byteStringToBooleanList $ booleanListToByteString [True,True,False,False]) ([True,True,False,False])
    ]


