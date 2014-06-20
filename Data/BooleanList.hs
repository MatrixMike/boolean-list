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

toLittleEndian = reverse

overlayRight :: [a] -> [a] -> [a]
overlayRight xs ys = reverse . map head . transpose . map reverse $ [ys,xs]

overlayLeft :: [b] -> [b] -> [b]
overlayLeft xs ys = map head . transpose $ [ys,xs]

padBooleanListLeft :: Int -> [Bool] -> [Bool]
padBooleanListLeft p xs = overlayRight (replicate p False) xs

padBooleanListRight :: Int -> [Bool] -> [Bool]
padBooleanListRight p xs = overlayLeft (replicate p False) xs

integerToBooleanListPadded :: Integral a => Int -> a -> [Bool]
integerToBooleanListPadded p x = padBooleanListLeft p (integerToBooleanList x)

takeIntegerFromBooleanList length xs = (booleanListToInteger h,rest)
  where (h,rest) = splitAt length xs

--booleanListToIntegers :: Integral a => Int -> [Bool] -> [a]
booleanListToIntegers p xs = unfoldr unfolder xs
 where unfolder [] = Nothing
       unfolder xs = Just (if boolsLeft < p then first (*(2^boolsLeft)) $ takeIntegerFromBooleanList p xs 
                                            else takeIntegerFromBooleanList p xs)
       boolsLeft = length xs

integersToBooleanListsPadded :: Integral a => Int -> [a] -> [[Bool]]
integersToBooleanListsPadded p xs = map (integerToBooleanListPadded p) xs

integersToBooleanListPadded :: Integral a => Int -> [a] -> [Bool]
integersToBooleanListPadded p xs = concat (integersToBooleanListsPadded p xs)

listOfPaddedIntegersToBooleanList pSize xs = concatMap integerToBooleanList $ booleanListToIntegers pSize xs

toBoolean8s xs = integersToBooleanListPadded 8 xs

precedentalEncoding xs = concat $ zipWith (\ x y -> integerToBooleanListPadded ( ceiling  . logBase 2 $ (fromIntegral x)) y )  (scanl1 max xs) xs

int8Chunks xs = booleanListToIntegers 8 xs
word8Chunks xs =  map (fromIntegral :: Integral a => a -> Word8) . int8Chunks $ xs

toByteString xs = Data.ByteString.pack (word8Chunks xs)

allBooleanLists = concat $ map (\x -> replicateM x [False,True] ) [1..]

{- slow versions for testing -}
encodeBooleanListInInteger' x = allBooleanLists !! x
encodeIntegerInBooleanList' xs = fromJust (elemIndex xs allBooleanLists)

encodeBooleanListInInteger x = integerToBooleanListPadded (baseComponent x) (x - ((2^(baseComponent x)) -2))
  where baseComponent x = floor (logBase 2 (fromIntegral (x+2)))

encodeIntegerInBooleanList xs = (2 ^ (length xs) -2) + (booleanListToInteger xs)



