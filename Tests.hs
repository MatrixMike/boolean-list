import BinaryList
import Test.HUnit

makeCase x y = TestCase (assertEqual "" x y)

main = runTestTT $ TestList [
     makeCase (integerToBinaryList 12) [True,True,False,False]
    ,makeCase (binaryListToInteger [True,True,False,False]) 12
    ]


