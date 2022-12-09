{-# LANGUAGE OverloadedStrings #-}

module A where

import Text.Parsec (Parsec, parse)
import Text.Parsec.Char
import Text.Parsec.String
import Text.ParserCombinators.Parsec.Number

run :: IO ()
run = do
  text <- readFile "./4A-input.txt"
  print $ show $ solve $ lines text

solve :: [String] -> Int
solve = sum . map countAssign . foldr parsing []

parsing :: String -> [((Int, Int), (Int, Int))] -> [((Int, Int), (Int, Int))]
parsing x xs = case parse parseLine "" x of
  Left err -> xs
  Right pts -> pts : xs

countAssign :: ((Int, Int), (Int, Int)) -> Int
countAssign ((a, b), (c, d))
  | a >= c && b <= d = 1
  | a <= c && b >= d = 1
  | otherwise = 0

parseLine :: Parser ((Int, Int), (Int, Int))
parseLine = do
  x <- int
  char '-'
  y <- int
  char ','
  a <- int
  char '-'
  b <- int
  return ((x, y), (a, b))