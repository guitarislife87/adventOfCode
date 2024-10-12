{-# LANGUAGE OverloadedStrings #-}

module A where

import Data.Char
import Data.List

run :: IO ()
run = do
  text <- readFile "./3A-input.txt"
  print $ show $ solve $ lines text

unique :: String -> String
unique [] = []
unique [x] = [x]
unique (x : xs)
  | x `elem` xs = unique xs
  | otherwise = x : unique xs

convert :: Char -> Int
convert x
  | isUpper x = ord x - ord 'A' + 27
  | otherwise = ord x - ord 'a' + 1

cartProd xs ys = [(x, y) | x <- xs, y <- ys]

solve :: [String] -> Int
solve xs = sum $ map same xs
  where
    half x = length x `div` 2
    container1 x = take (half x) x
    container2 x = take (half x) $ reverse x
    same x = sum $ map (convert . fst) $ filter (uncurry (==)) $ cartProd (unique $ container1 x) (unique $ container2 x)
