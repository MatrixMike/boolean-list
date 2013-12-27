import BitList
import Test.HUnit

makeCase x y = TestCase (assertEqual "" x y)

main = runTestTT $ TestList [
     makeCase (integerToBitList 12) [True,True,False,False]
    ,makeCase (bitListToInteger [True,True,False,False]) 12
    ]


