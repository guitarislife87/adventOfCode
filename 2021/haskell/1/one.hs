{-# LANGUAGE TypeApplications #-}

import System.IO
import Data.List

main :: IO ()
main = interact $ show . solve . map (read @Int) . lines

solve :: [Int] -> Int
solve x = sum . (map calculate) $ zip (reverse . tail . reverse $ x ) (tail x)

calculate :: (Int,Int) -> Int
calculate (x, y)
    | x < y = 1
    | otherwise = 0
