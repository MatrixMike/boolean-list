module BitList where

integerToBitList :: Integral a => a -> [Bool]
integerToBitList 0 = []
integerToBitList n = integerToBitList div ++ [toEnum (fromIntegral rem)]
  where (div,rem) = divMod n 2

bitListToInteger :: [Bool] -> Int
bitListToInteger (x:[]) = fromEnum x
bitListToInteger (x:xs) = ((2 * fromEnum x) ^ (length xs)) + rest
  where rest = bitListToInteger xs
bitListToInteger [] = 0
      
 
       