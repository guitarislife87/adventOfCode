import System.IO
import Data.List

main :: IO ()
main = interact $ show . solve . lines

solve :: [String] -> Int
solve = product . operations . map cycle

operations :: [String] -> [Int]
operations input = map snd3 
    [ foldl (countLine False 1) (0,0,False) input
    , foldl (countLine False 3) (0,0,False) input
    , foldl (countLine False 5) (0,0,False) input
    , foldl (countLine False 7) (0,0,False) input
    , foldl (countLine True  1) (0,0,False) input
    ]

countLine :: Bool -> Int -> (Int,Int,Bool) -> String -> (Int, Int, Bool)
countLine skipLineEnabled toRight (toSkip, treeCount, shouldSkipLine) currentRow 
    | skipLineEnabled && shouldSkipLine = (toSkip, treeCount, not shouldSkipLine)
    | tree == '#'                       = (toSkip + toRight, treeCount+1, not shouldSkipLine)
    | otherwise                         = (toSkip + toRight, treeCount, not shouldSkipLine)
    where tree = head $ drop toSkip currentRow 

snd3 (_, a, _) = a
