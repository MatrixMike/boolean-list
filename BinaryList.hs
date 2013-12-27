module BinaryList where

integerToBinaryList :: Integral a => a -> [Bool]
integerToBinaryList 0 = []
integerToBinaryList n = integerToBinaryList div ++ [toEnum (fromIntegral rem)]
  where (div,rem) = divMod n 2

binaryListToInteger :: [Bool] -> Int
binaryListToInteger (x:[]) = fromEnum x
binaryListToInteger (x:xs) = ((2 * fromEnum x) ^ (length xs)) + rest
  where rest = binaryListToInteger xs
binaryListToInteger [] = 0
      
 
       