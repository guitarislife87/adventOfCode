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
    let policyCount = Data.List.length $ Data.List.filter (== toFind) $ unpack password
    return $ if policyCount >= lower && policyCount <= upper then 1 else 0
