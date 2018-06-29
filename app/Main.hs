{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Data.Text
import           Database

main :: IO ()
main = do
    item <- findItem
    putStrLn $ unpack item
