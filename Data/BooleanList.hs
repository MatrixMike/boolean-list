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

integerToBooleanListBigEndian = integerToBooleanList
bigEndianBooleanListToInteger = booleanListToInteger

integerToBooleanList' True = integerToBooleanListBigEndian
integerToBooleanList' False = integerToBooleanListLittleEndian

integerToBooleanListLittleEndian = toLittleEndian . integerToBooleanList
littleEndianBooleanListToInteger = booleanListToInteger . fromLittleEndian

booleanListToInteger' True = bigEndianBooleanListToInteger
booleanListToInteger' False = littleEndianBooleanListToInteger

toLittleEndian = reverse
fromLittleEndian = reverse

overlayRight :: [a] -> [a] -> [a]
overlayRight xs ys = reverse . map head . transpose . map reverse $ [ys,xs]

overlayLeft :: [b] -> [b] -> [b]
overlayLeft xs ys = map head . transpose $ [ys,xs]

padBooleanListLeft :: Int -> [Bool] -> [Bool]
padBooleanListLeft p xs = overlayRight (replicate p False) xs

padBooleanListRight :: Int -> [Bool] -> [Bool]
padBooleanListRight p xs = overlayLeft (replicate p False) xs

padBooleanList' :: Bool -> Int -> [Bool] -> [Bool]
padBooleanList' True = padBooleanListLeft
padBooleanList' False = padBooleanListRight

integerToBooleanListPadded :: Integral a => Int -> a -> [Bool]
integerToBooleanListPadded p x = padBooleanListLeft p (integerToBooleanList x)

integerToBooleanListPadded'' :: Bool -> Bool -> Int -> Integer -> [Bool]
integerToBooleanListPadded'' s e p x = padBooleanList' s p (integerToBooleanList' e x)

integerToBigEndianBooleanListPadded = integerToBooleanListPadded'' True True
integerToLittleEndianBooleanListPadded = integerToBooleanListPadded'' True False

integerToBigEndianBooleanListPaddedLeft = integerToBooleanListPadded'' True True
integerToLittleEndianBooleanListPaddedLeft = integerToBooleanListPadded'' True False

integerToBigEndianBooleanListPaddedRight = integerToBooleanListPadded'' False True
integerToLittleEndianBooleanListPaddedRight = integerToBooleanListPadded'' False False

takeIntegerFromBooleanList = takeIntegerFromBooleanList' True
takeIntegerFromBooleanList' b length xs = (booleanListToInteger' b h,rest)
  where (h,rest) = splitAt length xs
  
takeIntegerFromBooleanListLittleEndian = takeIntegerFromBooleanList' False
takeIntegerFromBooleanListBigEndian = takeIntegerFromBooleanList' True

booleanListToIntegers' e p xs = unfoldr unfolder xs
 where unfolder [] = Nothing
       unfolder xs = Just (if length (take p xs) < p then first (*(2^(p-length xs))) $ takeIntegerFromBooleanList' e p xs 
												     else takeIntegerFromBooleanList' e p xs)
													 
booleanListToIntegers = booleanListToIntegers' True
bigEndianBooleanListToIntegers = booleanListToIntegers' True
littleEndianBooleanListToIntegers = booleanListToIntegers' False

integersToBooleanListsPadded :: Integral a => Int -> [a] -> [[Bool]]
integersToBooleanListsPadded p xs = map (integerToBooleanListPadded p) xs

integersToBooleanListsPadded'' s e p xs = map (integerToBooleanListPadded'' s e p) xs

integersToBooleanListPadded :: Integral a => Int -> [a] -> [Bool]
integersToBooleanListPadded p xs = concat (integersToBooleanListsPadded p xs)

integersToBooleanListPadded' e p xs = concat (integersToBooleanListsPadded'' e e p xs)

integersToBigEndianBooleanListPadded = integersToBooleanListPadded' True
integersTolittleEndianBooleanListPadded = integersToBooleanListPadded' False

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