{-# LANGUAGE OverloadedStrings #-}

module B where

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

cartProd xs ys zs = [(x, y, z) | x <- xs, y <- ys, z <- zs]

chunk :: [String] -> [(String, String, String)]
chunk (x : y : z : xs) = (x, y, z) : chunk xs
chunk _ = []

same :: String -> String -> String -> Int
same x y z = sum $ map (\(x, _, _) -> convert x) $ filter (\(x, y, z) -> x == y && y == z) $ cartProd (unique x) (unique y) (unique z)

initVal :: [[String]]
initVal = [[]]

solve :: [String] -> Int
solve = sum . map (\(x, y, z) -> same x y z) . chunk
