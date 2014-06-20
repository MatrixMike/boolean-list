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
								     "\n" ++ (makeGhciLine (expressions!!0)) ++ "\n" ++ (show $(return (getExpression (expressions!!0))))  
								++ "\n\n" ++ (makeGhciLine (expressions!!1)) ++ "\n" ++ (show $(return (getExpression (expressions!!1))))
								++ "\n\n" ++ (makeGhciLine (expressions!!2)) ++ "\n" ++ (show $(return (getExpression (expressions!!2))))
								++ "\n\n" ++ (makeGhciLine (expressions!!3)) ++ "\n" ++ (show $(return (getExpression (expressions!!3))))
								++ "\n\n" ++ (makeGhciLine (expressions!!4)) ++ "\n" ++ (show $(return (getExpression (expressions!!4))))
								++ "\n\n" ++ (makeGhciLine (expressions!!5)) ++ "\n" ++ (show $(return (getExpression (expressions!!5))))
								++ "\n\n" ++ (makeGhciLine (expressions!!6)) ++ "\n" ++ (show $(return (getExpression (expressions!!6))))
								++ "\n\n" ++ (makeGhciLine (expressions!!7)) ++ "\n" ++ (show $(return (getExpression (expressions!!7))))
								++ "\n\n" ++ (makeGhciLine (expressions!!8)) ++ "\n" ++ (show $(return (getExpression (expressions!!8))))
								++ "\n\n" ++ (makeGhciLine (expressions!!9)) ++ "\n" ++ (show $(return (getExpression (expressions!!9))))
							 ) fileLines
          writeFile "README.md" modifiedFile