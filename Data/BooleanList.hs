module Data.BooleanList where

import Data.List
import Data.Word
import qualified Data.ByteString

integerToBooleanList :: Integral a => a -> [Bool]
integerToBooleanList 0 = []
integerToBooleanList n = integerToBooleanList div ++ [toEnum (fromIntegral rem)]
  where (div,rem) = divMod n 2

booleanListToInteger :: Integral a => [Bool] -> a
booleanListToInteger (x:[]) = fromIntegral (fromEnum x)
booleanListToInteger (x:xs) = ((2 * fromIntegral (fromEnum x)) ^ (length xs)) + rest
  where rest = booleanListToInteger xs
booleanListToInteger [] = 0

takeIntegerFromBooleanList length xs = (booleanListToInteger h,rest)
 where (h,rest) = splitAt length xs

integerChunks n xs = unfoldr (\xs -> case xs of [] -> Nothing ; _ -> Just (takeIntegerFromBooleanList n xs)) xs

int8Chunks xs = integerChunks 8 xs
word8Chunks xs =  map (fromIntegral :: Integral a => a -> Word8) . int8Chunks $ xs

listOfIntegersToListToBooleanList = concatMap integerToBooleanList

overlayRight xs ys = reverse . map head . transpose . map reverse $ [ys,xs]

integerToBooleanListPadded p x = overlayRight (replicate p False) (integerToBooleanList  x)

integersToPaddedBooleansLists p xs = map (integerToBooleanListPadded p) xs

integersToPaddedBooleans p xs = concat (integersToPaddedBooleansLists p xs)

toBoolean8s xs = integersToPaddedBooleans 8 xs

booleanListToByteString = Data.ByteString.pack . word8Chunks
byteStringToBooleanList = listOfIntegersToListToBooleanList . Data.ByteString.unpack
