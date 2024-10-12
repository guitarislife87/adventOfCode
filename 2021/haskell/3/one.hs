{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

import Control.Monad
import Data.List
import Data.Text (pack, unpack)
import System.IO

main :: IO ()
main = interact $ show . solve . lines

solve :: [String] -> Int
solve = product . bintodecs . map (head . middle . sort . map (\x -> read @Int [x])) . transpose

bintodecs :: [Int] -> [Int]
bintodecs = foldl (\[g, e] x -> [x + 2 * g, notX x + 2 * e]) [0, 0]

middle :: [a] -> [a]
middle l@(_ : _ : _ : _) = middle $ tail $ init l
middle l = l

notX :: Int -> Int
notX x
  | x == 0 = 1
  | x == 1 = 0
  | otherwise = 0