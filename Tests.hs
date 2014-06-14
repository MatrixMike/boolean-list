import Data.BooleanList
import Test.HUnit
import qualified Data.ByteString as BS
import Data.Char

makeCase x y = TestCase (assertEqual "" x y)

main = runTestTT $ TestList [
     makeCase (integerToBooleanList 12) [True,True,False,False]
    ,makeCase (booleanListToInteger [True,True,False,False]) 12
    ,makeCase (splitIntegersAtBits 8 10 [7,224]) (31,[32])
    -- 0000011111100000 --
    --        >< 
              -- |
    ,makeCase (precedentalEncoding [1,3,1]) [True,True,True,False,True]
    ]

-- f :: BS.ByteString
f = BS.pack $ map (fromIntegral . ord) $ "The rain in spain falls mainly on the plane"


