{-# LANGUAGE OverloadedStrings #-}
module B where

import Data.List

run :: IO ()
run = do
    text <- readFile "./1A-input.txt"
    print $ show $ sum $ take 3 $ reverse $ sort $ snd $ foldr solve (0,[]) $ (lines text) ++ [""]

solve :: String -> (Int, [Int]) -> (Int, [Int])
solve "" (curr, results) = (0, results ++ [curr])
solve value (curr, results) = (curr + read value, results)