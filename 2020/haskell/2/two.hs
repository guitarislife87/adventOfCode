{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

import System.IO
import Control.Monad
import Data.List
import Data.Either
import Data.Text
import Data.Attoparsec.Text

main :: IO ()
main = System.IO.interact $ show . sum . rights . Data.List.map (parseOnly caseParser . pack) . Data.List.lines

caseParser :: Parser Int
caseParser = do
    lower <- decimal
    char '-'
    upper <- decimal
    char ' '
    toFind <- anyChar
    char ':'
    char ' '
    password <- takeText
    let firstChar = Data.List.head $ Data.List.drop (lower - 1) $ unpack password
    let lastChar = Data.List.head $ Data.List.drop (upper - 1) $ unpack password
    return $ if (firstChar == toFind) /= (lastChar == toFind) then 1 else 0
