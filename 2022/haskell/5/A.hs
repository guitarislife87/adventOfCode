{-# LANGUAGE OverloadedStrings #-}

module A where

import Data.List
import Text.Parsec (Parsec, many, parse)
import Text.Parsec.Char
import Text.Parsec.String
import Text.ParserCombinators.Parsec.Number
import Text.ParserCombinators.Parsec

run :: IO ()
run = do
  text <- readFile "./5A-input.txt"
  print $ show $ solve text

solve :: String -> String
solve x = case parse parseInput "" x of
    Left err -> show err
    Right (stacks, instructions) -> buildAndProcess(stacks, instructions)

buildAndProcess :: ([StackInput],[InstructionInput]) -> String
buildAndProcess (s,i) =
    head . zipWith (++) . process . build
    where
        build = map (map filter (!= Nothing )) $ transpose $ map (\(x,y,z) -> [x,y,z]) s
        process x = foldr processAgg x i
        processAgg (c,s,d) stackStub

toItem :: Char -> Maybe Char
toItem x
  | x == " " = Nothing
  | otherwise = Just x

parseInput :: Parser ([StackInput],[InstructionInput])
parseInput = do
  stacks <- many parseStackLine
  string " 1   2   3 "
  endOfLine
  endOfLine
  instructions <- many parseInstruction
  return (stacks, instructions)

type StackInput = (Maybe Char, Maybe Char, Maybe Char)
parseStackLine :: Parser StackInput
parseStackLine = do
  string "[" <|> string " "
  a <- letter
  string "] [" <|> string "   "
  b <- letter
  string "] [" <|> string "   "
  c <- letter
  string "]" <|> string " "
  endOfLine
  return (toItem a, toItem b, toItem c)

type InstructionInput = (Int, Int, Int)

parseInstruction :: Parser InstructionInput
parseInstruction = do
  string "move "
  a <- int
  string " from "
  b <- int
  string " to "
  c <- int
  endOfLine
  return (a, b, c)