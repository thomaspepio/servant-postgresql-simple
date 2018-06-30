{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Data.Text
import           Database
import           Model

main :: IO ()
main = do
    item <- findItem 1
    print item
