{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

import Control.Monad
import Data.List
import Data.Text (pack, unpack)
import System.IO

main :: IO ()
main = interact $ show . solve . lines

solve :: [String] -> Int
solve x = product . binToDecs $ filter (\y -> isValid (analysis values) y) values
  where
    values = charToBin x

isValid :: [Int] -> [Int] -> Bool
isValid xs valid = foldl (\acc (i, x) -> acc && x == valid !! i) True (zip [0 ..] xs)

analysis :: [[Int]] -> [Int]
analysis = map (head . middle . sort) . transpose

binToDecs :: [Int] -> [Int]
binToDecs = foldl (\[g, e] x -> [x + 2 * g, notX x + 2 * e]) [0, 0]

charToBin :: [String] -> [[Int]]
charToBin = map (map (\x -> read @Int [x]))

middle :: [a] -> [a]
middle l@(_ : _ : _ : _) = middle $ tail $ init l
middle l = l

notX :: Int -> Int
notX x
  | x == 0 = 1
  | x == 1 = 0
  | otherwise = 0