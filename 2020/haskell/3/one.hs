import System.IO
import Data.List

main :: IO ()
main = interact $ show . solve . lines

solve :: [String] -> Int
solve = snd . foldl' countLine (0,0) . map cycle

countLine :: (Int,Int) -> String -> (Int, Int)
countLine (toSkip, treeCount) currentRow 
    | tree == '#' = (toSkip+3,treeCount+1)
    | otherwise   = (toSkip+3,treeCount)
    where tree = head $ drop toSkip currentRow
