{-# LANGUAGE TypeApplications #-}

import System.IO
import Data.List

main :: IO ()
main = interact $ show . solve . map (read @Int) . lines

solve :: [Int] -> Int
solve x = sum . (map calculate) $ zip (reverse . tail . reverse $ newX ) (tail newX)
    where newX = zipWith3 (\x y z -> x + y + z) (reverse . tail . tail . reverse $ x) (reverse . tail . reverse . tail $ x) (tail $ tail x)

calculate :: (Int,Int) -> Int
calculate (x, y)
    | x < y = 1
    | otherwise = 0
