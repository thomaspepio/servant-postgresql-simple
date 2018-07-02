{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Data.Aeson
import           Data.ByteString.Lazy.Char8 hiding (putStrLn)
import           Data.Maybe
import           Data.Text                  hiding (pack)

import           Database
import           Endpoints
import           Model

main :: IO ()
main = examplePostgres

-- Example #2 : Aeson
exampleMessage :: String
exampleMessage = "{\"id\":0,\"name\":\"foo\",\"description\":\"bar\"}"

exampleAeson :: IO ()
exampleAeson = do
    putStrLn "Decoding an item"
    print $ encode Item { itemId = 0, name = "foo", description = "bar" }
    putStrLn ""
    putStrLn "Encoding an item"
    print decoded
        where
            decoded = decode (pack exampleMessage) :: Maybe Item

-- Example #1 : Postgresql
examplePostgres :: IO ()
examplePostgres = do
    item <- findItem 1
    print item
