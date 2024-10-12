{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

import System.IO
import Control.Monad
import Data.List
import Data.Either
import Data.Attoparsec.Text
import Data.Text (pack, unpack)

main :: IO ()
main = interact $ show . solve . rights . map (parseOnly caseParser . pack) . lines

caseParser :: Parser (String, Int)
caseParser = do
    direction <- choice [string "forward", string "up", string "down"]
    char ' '
    distance <- decimal
    return $ (unpack direction, distance)

solve :: [(String, Int)] -> Int
solve =  product . Data.List.take 2 . foldl addUp [0,0,0]

addUp :: [Int] ->(String, Int) -> [Int]
addUp (hor:depth:aim:_) (direction, distance) 
    | direction == "forward" = [hor + distance, depth + (aim * distance), aim]
    | direction == "down"    = [hor, depth, aim + distance]
    | direction == "up"      = [hor, depth, aim - distance]
    | otherwise              = [hor, depth, aim]