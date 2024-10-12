{-# LANGUAGE TypeApplications #-}

import System.IO
import Control.Monad
import Data.List

main :: IO ()
main = interact $ (++ "\n") . show . solve . map (read @Int) . lines

solve :: [Int] -> Int
solve = snd . head . filter (\(x,_) -> x == 2020) . compute2

compute2 :: [Int] -> [(Int, Int)]
compute2 (x:[]) = []
compute2 (x:xs) = map (\(y,z) -> (y+x, z*x)) (compute xs) ++ compute2 xs

compute :: [Int] -> [(Int, Int)]
compute (x:[]) = []
compute (x:xs) = map (\z -> (x + z, x * z)) xs ++ compute  xs
