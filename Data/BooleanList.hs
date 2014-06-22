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

padBooleanList = padBooleanListLeft

integerToBooleanListPadded :: Integral a => Int -> a -> [Bool]
integerToBooleanListPadded p x = padBooleanListLeft p (integerToBooleanList x)

integerToBooleanListPadded'' ::  Bool -> Int -> Integer -> [Bool]
integerToBooleanListPadded'' e p x = padBooleanList' e p (integerToBooleanList' e x)

integerToBigEndianBooleanListPadded = integerToBooleanListPadded'' True
integerToLittleEndianBooleanListPadded = integerToBooleanListPadded'' False

takeIntegerFromBooleanList = takeIntegerFromBooleanList' True
takeIntegerFromBooleanList' b length xs = (booleanListToInteger' b h,rest)
  where (h,rest) = splitAt length xs
  
takeIntegerFromBooleanListLittleEndian = takeIntegerFromBooleanList' False
takeIntegerFromBooleanListBigEndian = takeIntegerFromBooleanList' True

booleanListToIntegers = booleanListToIntegers' True
bigEndianBooleanListToIntegers = booleanListToIntegers' True
littleEndianBooleanListToIntegers = booleanListToIntegers' False

booleanListToIntegers' = booleanListToIntegers'' False

booleanListLittleEndianToIntegersTerminated = booleanListToIntegers'' True False
booleanListToIntegersTerminated = booleanListToIntegers'' True True

booleanListToIntegers'' t e p [] = []  
booleanListToIntegers'' t e p xs | bitsLeftOver && t = booleanListToIntegers'' False e p (xs ++ terminator) 
                                 | bitsLeftOver && (not t) = (op(2^bitsToGo) int) : []
                                 | otherwise = int : booleanListToIntegers'' t e p rest  
 where (int,rest) = takeIntegerFromBooleanList' e p xs
       bitsLeftOver = listLengthIsSmallerThanOrEqualTo (p-1) xs
       bitsToGo = p - (length xs `rem` p)
       terminator = ((take (bitsToGo + p) (False:repeat True)))
       op = if e then (*) else flip const

isTerminator p xs | listLengthIsSmallerThanOrEqualTo (2*p) xs = isTerminator' xs
                  | otherwise = False

isTerminator' (False:xs) = all (==True) xs
isTerminator' _ = False

takeWhileRest p xs@(x:xs') = if p xs then x : takeWhileRest p xs' else []
takeWhileRest p [] = []

listLengthIsSmallerThanOrEqualTo x xs = null $ drop x xs

integersToBooleanListPadded = integersToBooleanListPadded' True
integersToBooleanListTerminated = integersToBooleanListPaddedTerminated' True
integersToBooleanListsPadded = integersToBooleanListsPadded' True
integersToBigEndianBooleanListPadded = integersToBooleanListPadded' True
integersToLittleEndianBooleanListPadded = integersToBooleanListPadded' False
integersToBooleanListPadded' = integersToBooleanListPadded'' False
integersToBooleanListPaddedTerminated' = integersToBooleanListPadded'' True
integersToBooleanListPadded'' t e p xs = (if t then takeWhileRest (not . isTerminator p) else id) (concat (integersToBooleanListsPadded' e p xs))
integersToBooleanListsPadded' e p xs = map (integerToBooleanListPadded'' e p) xs

listOfPaddedIntegersToBooleanList pSize xs = concatMap integerToBooleanList $ booleanListToIntegers pSize xs

toBoolean8s xs = integersToBooleanListPadded 8 xs

precedentalEncoding xs = concat $ zipWith (\ x y -> integerToBooleanListPadded (ceiling . logBase 2 $ (fromIntegral x)) y)  (scanl1 max xs) xs

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
