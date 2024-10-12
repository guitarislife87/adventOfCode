{-# LANGUAGE OverloadedStrings #-}
module B where

run :: IO ()
run = do
    text <- readFile "./2A-input.txt"
    print $ show $ foldr solve 0 $ lines text

solve :: String -> Int -> Int
solve entry total
    | entry == "A X" = (3 + 0) + total
    | entry == "A Y" = (1 + 3) + total
    | entry == "A Z" = (2 + 6) + total
    | entry == "B X" = (1 + 0) + total
    | entry == "B Y" = (2 + 3) + total
    | entry == "B Z" = (3 + 6) + total
    | entry == "C X" = (2 + 0) + total
    | entry == "C Y" = (3 + 3) + total
    | entry == "C Z" = (1 + 6) + total
    | otherwise = 0