{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Data.Aeson
import           Data.ByteString.Lazy.Char8 hiding (putStrLn)
import           Data.Maybe
import           Data.Text                  hiding (pack)
import           Network.Wai
import           Network.Wai.Handler.Warp

import           Database
import           Endpoints
import           Model

main :: IO ()
main = exampleServant

-- Example #3 : Servant
exampleServant :: IO ()
exampleServant = run 8080 application

-- Example #2 : Aeson
exampleAeson :: IO ()
exampleAeson = do
    putStrLn "Decoding an item"
    print $ encode Item { itemId = 0, name = "foo", description = "bar", quantity = 1 }
    putStrLn ""
    putStrLn "Encoding an item"
    print decoded
        where
            decoded = decode (pack "{\"id\":0,\"name\":\"foo\",\"description\":\"bar\",\"quantity\":1}") :: Maybe Item

-- Example #1 : Postgresql
examplePostgres :: IO ()
examplePostgres = do
    item <- findItem 1
    print item
