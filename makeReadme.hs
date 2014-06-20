{-# LANGUAGE TemplateHaskell #-} 
import System.IO
import Language.Haskell.TH 
import Language.Haskell.Meta.Parse.Careful 
import Data.Either
import GetExpression
import Data.List
import Data.BooleanList
  
insertAt = (\n x xs -> case splitAt n xs of { (a, b) -> a ++ [x] ++ b })
  
main = do file <- readFile "README.md.template"
          let fileLines = lines file
          let modifiedFile = unlines $ insertAt (length fileLines -1) (
								           (makeGhciLine (expressions!!0)) ++ "\n" ++ (show $(return (getExpression (expressions!!0))))  
								++ "\n" ++ (makeGhciLine (expressions!!1)) ++ "\n" ++ (show $(return (getExpression (expressions!!1))))
								++ "\n" ++ (makeGhciLine (expressions!!2)) ++ "\n" ++ (show $(return (getExpression (expressions!!2))))
								++ "\n" ++ (makeGhciLine (expressions!!3)) ++ "\n" ++ (show $(return (getExpression (expressions!!3))))
								++ "\n" ++ (makeGhciLine (expressions!!4)) ++ "\n" ++ (show $(return (getExpression (expressions!!4))))
								++ "\n" ++ (makeGhciLine (expressions!!5)) ++ "\n" ++ (show $(return (getExpression (expressions!!5))))
							 ) fileLines
          writeFile "README.md" modifiedFile