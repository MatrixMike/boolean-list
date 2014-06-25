{-# LANGUAGE TemplateHaskell #-} 
import System.IO
import Language.Haskell.TH 
import Language.Haskell.Meta.Parse.Careful 
import Data.Either
import GetExpression
import Data.List
import Data.BooleanList
import Data.ByteString.Char8 (pack)
  
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
								++ "\n\n" ++ (makeGhciLine (expressions!!10)) ++ "\n" ++ (show $(return (getExpression (expressions!!10))))
								++ "\n\n" ++ (makeGhciLine (expressions!!11)) ++ "\n" ++ (show $(return (getExpression (expressions!!11))))
								++ "\n\n" ++ (makeGhciLine (expressions!!12)) ++ "\n" ++ (show $(return (getExpression (expressions!!12))))
						--		++ "\n\n" ++ (makeGhciLine (expressions!!13)) ++ "\n" ++ (show $(return (getExpression (expressions!!13))))
						--		++ "\n\n" ++ (makeGhciLine (expressions!!14)) ++ "\n" ++ (show $(return (getExpression (expressions!!14))))
					--			++ "\n\n" ++ (makeGhciLine (expressions!!15)) ++ "\n" ++ (show $(return (getExpression (expressions!!15))))
					--			++ "\n\n" ++ (makeGhciLine (expressions!!16)) ++ "\n" ++ (show $(return (getExpression (expressions!!16))))
					--			++ "\n\n" ++ (makeGhciLine (expressions!!17)) ++ "\n" ++ (show $(return (getExpression (expressions!!17))))
					--			++ "\n\n" ++ (makeGhciLine (expressions!!18)) ++ "\n" ++ (show $(return (getExpression (expressions!!18))))
			--					++ "\n\n" ++ (makeGhciLine (expressions!!19)) ++ "\n" ++ (show $(return (getExpression (expressions!!19))))
			--					++ "\n\n" ++ (makeGhciLine (expressions!!20)) ++ "\n" ++ (show $(return (getExpression (expressions!!20))))
			--					++ "\n\n" ++ (makeGhciLine (expressions!!21)) ++ "\n" ++ (show $(return (getExpression (expressions!!21))))
		--						++ "\n\n" ++ (makeGhciLine (expressions!!22)) ++ "\n" ++ (show $(return (getExpression (expressions!!22))))
							 ) fileLines
          writeFile "README.md" modifiedFile
