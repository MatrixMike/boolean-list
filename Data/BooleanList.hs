module Data.BooleanList where

import Data.List
import Data.Word
import qualified Data.ByteString
import Control.Arrow
import Control.Monad

integerToBooleanList :: Integral a => a -> [Bool]
integerToBooleanList 0 = []
integerToBooleanList n = integerToBooleanList div ++ [toEnum (fromIntegral rem)]
  where (div,rem) = divMod n 2

booleanListToInteger :: Integral a => [Bool] -> a
booleanListToInteger (x:[]) = fromIntegral (fromEnum x)
booleanListToInteger (x:xs) = ((2 * fromIntegral (fromEnum x)) ^ (length xs)) + rest
  where rest = booleanListToInteger xs
booleanListToInteger [] = 0

integerChunks :: Integral a => Int -> [Bool] -> [a]
integerChunks n xs = unfoldr (\xs -> case xs of [] -> Nothing ; _ -> Just (takeIntegerFromBooleanList n xs)) xs

integerToBooleanListPadded :: Integral a => Int -> a -> [Bool]
integerToBooleanListPadded p x = overlayRight (replicate p False) (integerToBooleanList  x)

integersToPaddedBooleansLists :: Integral a => Int -> [a] -> [[Bool]]
integersToPaddedBooleansLists p xs = map (integerToBooleanListPadded p) xs

integersToPaddedBooleans :: Integral a => Int -> [a] -> [Bool]
integersToPaddedBooleans p xs = concat (integersToPaddedBooleansLists p xs)

splitIntegersAtBits pSize n xs = booleanListToInteger *** (integerChunks pSize) $ (splitAt n (integersToPaddedBooleans pSize xs))

takeIntegerFromBooleanList length xs = (booleanListToInteger h,rest)
 where (h,rest) = splitAt length xs

listOfPaddedIntegersToBooleanList pSize xs = concatMap integerToBooleanList $ integerChunks pSize xs

overlayRight xs ys = reverse . map head . transpose . map reverse $ [ys,xs]

toBoolean8s xs = integersToPaddedBooleans 8 xs

precedentalEncoding xs = concat $ zipWith (\ x y -> integerToBooleanListPadded ( (+1) . floor  . logBase 2 $ (fromIntegral x)) y )  (scanl1 max xs) xs

int8Chunks xs = integerChunks 8 xs
word8Chunks xs =  map (fromIntegral :: Integral a => a -> Word8) . int8Chunks $ xs

