{-# LANGUAGE TypeApplications #-}

import System.IO
import Control.Monad
import Data.List

main :: IO ()
main = interact $ show . solve . map (read @Int) . lines

solve :: [Int] -> Int
solve = snd . head  . filter (\(x,_) -> x == 2020) . compute

compute :: [Int] -> [(Int, Int)]
compute (x:[]) = []
compute (x:xs) = map (\y -> (x + y, x * y)) xs ++ compute xs
