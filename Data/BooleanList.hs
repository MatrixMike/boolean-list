module Data.BooleanList where

import Data.List
import Data.Word
import qualified Data.ByteString

integerToBooleanList :: Integral a => a -> [Bool]
integerToBooleanList 0 = []
integerToBooleanList n = integerToBooleanList div ++ [toEnum (fromIntegral rem)]
  where (div,rem) = divMod n 2

booleanListToInteger :: [Bool] -> Int
booleanListToInteger (x:[]) = fromEnum x
booleanListToInteger (x:xs) = ((2 * fromEnum x) ^ (length xs)) + rest
  where rest = booleanListToInteger xs
booleanListToInteger [] = 0

takeIntegerFromBooleanList length xs = (booleanListToInteger h,rest)
 where (h,rest) = splitAt length xs

integerChunks n = unfoldr (\xs -> case xs of [] -> Nothing ; _ -> Just (takeIntegerFromBooleanList n xs))

word8Chunks =  map (fromIntegral :: Int -> Word8) . integerChunks 8 

booleanListToByteString = Data.ByteString.pack . word8Chunks

byteStringToBooleanList = listOfIntegersToListToBooleanList . Data.ByteString.unpack

listOfIntegersToListToBooleanList = concatMap integerToBooleanList


