{-# LANGUAGE OverloadedStrings #-}
module A where

run :: IO ()
run = do
    text <- readFile "./1A-input.txt"
    print $ show $ snd $ foldr solve (0,0) $ (lines text) ++ [""]

solve :: String -> (Int, Int) -> (Int, Int)
solve "" (curr, max)
    | curr > max = (0, curr)
    | otherwise = (0, max)
solve value (curr, max) = (curr + read value, max)
