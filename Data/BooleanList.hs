module Data.BooleanList where

import Data.List
import Data.Word
import qualified Data.ByteString
import Control.Arrow
import Control.Monad
import Data.Maybe

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

padBoolean :: Int -> [Bool] -> [Bool]
padBoolean p xs = overlayRight (replicate p False) xs

integerToBooleanListPadded :: Integral a => Int -> a -> [Bool]
integerToBooleanListPadded p x = padBoolean p (integerToBooleanList x)

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

precedentalEncoding xs = concat $ zipWith (\ x y -> integerToBooleanListPadded ( ceiling  . logBase 2 $ (fromIntegral x)) y )  (scanl1 max xs) xs

int8Chunks xs = integerChunks 8 xs
word8Chunks xs =  map (fromIntegral :: Integral a => a -> Word8) . int8Chunks $ xs

toByteString xs = Data.ByteString.pack (word8Chunks xs)

allBooleanLists = concat $ map (\x -> replicateM x [False,True] ) [1..]

{- slow versions for testing -}
encodeBooleanListInInteger' x = allBooleanLists !! x
encodeIntegerInBooleanList' xs = fromJust (elemIndex xs allBooleanLists)

encodeBooleanListInInteger x = integerToBooleanListPadded (baseComponent x) (x - ((2^(baseComponent x)) -2))
  where baseComponent x = floor (logBase 2 (fromIntegral (x+2)))

encodeIntegerInBooleanList xs = (2 ^ (length xs) -2) + (booleanListToInteger xs)



