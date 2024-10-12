{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

import System.IO
import Control.Monad
import Data.List
import Data.Either
import Data.Text
import Data.Attoparsec.Text

main :: IO ()
main = System.IO.interact $ show . count . rights . Data.List.map (parseOnly caseParser . pack) . Data.List.lines

toCases :: [String] -> [String]
toCases = foldl (\(result, previous) item
    | result == []   = ([item], item)
    | previous == "" = ([item] ++ result, item)
    | item == ""     = (result,item) 
    | otherwise      = ([head result ++ " " ++ item] ++ tail result , item)
) ([],"")

passportParser :: Parser

birthYearParser :: Parser String
birthYearParser = do
    string "byr:"
    value <- takeText
    return $ value

issueYearParser :: Parser String
issueYearParser = do
    string "iyr:"
    value <- takeText
    return $ value

expirationYearParser :: Parser Int
expirationYearParser = do
    string "eyr:"
    value <- decimal
    takeText
    return $ value

heightParser :: Parser String
heightParser = do
    string "hgt:"
    value <- takeText
    return $ value

hairColorParser :: Parser String
hairColorParser = do
    string "hcl:"
    value <- takeText
    return $ value

eyeColorParser :: Parser String
eyeColorParser = do
    string "ecl:"
    value <- takeText
    return $ value

passportIdParser :: Parser Int
passportIdParser = do
    string "pid:"
    value <- decimal
    takeText
    return $ value

countryIdParser :: Parser Int
countryIdParser = do
    string "cid:"
    value <- decimal
    takeText
    return $ value
