{-# LANGUAGE OverloadedStrings #-}
module Persistence (
    Item(..), ItemId, ItemAvailability,
    findItemById, findItemByNameAndDescription, addNewItem
) where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import           Data.ByteString                      hiding (putStrLn)
import           Data.Either
import           Data.Int
import           Data.Maybe
import           Data.Monoid
import           Data.Text                            hiding (pack)
import           Data.Word
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.FromField
import           Database.PostgreSQL.Simple.FromRow
import           System.Environment

import           Environment
import           Item

connection :: IO Connection -- How to get a connection from postgres-simple ?
connection = undefined

findItemById :: ItemId -> IO ItemAvailability
findItemById = undefined

findItemByNameAndDescription :: Item -> IO ItemAvailability
findItemByNameAndDescription = undefined

addNewItem :: Item -> IO (Either Text Int64)
addNewItem = undefined