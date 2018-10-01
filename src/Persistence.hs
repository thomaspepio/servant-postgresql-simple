{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
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

instance FromRow Item where
    fromRow = Item <$> field <*> field <*> field

instance FromRow Stock where
    fromRow = Stock <$> fromRow <*> field

connection :: IO Connection
connection = do
    (Config dbhost dbuser dbpassword  dbname) <- readConfiguration
    connect defaultConnectInfo {
        connectHost = dbhost,
        connectPort = 5432,
        connectUser = dbuser,
        connectPassword = dbpassword,
        connectDatabase = dbname
    }

findItemById :: ItemId -> IO ItemAvailability
findItemById id = do
    conn <- connection
    result <- query conn "select id, name, description, quantity from item where id=?" [id]
    maybe (error "invalid constraint") return $ checkAvailability result

checkAvailability :: [Stock] -> Maybe ItemAvailability
checkAvailability [Stock _ 0]  = Just NotAvailable
checkAvailability [Stock i qt] = Just $ Available i
checkAvailability []           = Just DoesNotExists
checkAvailability _            = Nothing

findItemByNameAndDescription :: Item -> IO ItemAvailability
findItemByNameAndDescription = undefined

addNewItem :: Item -> IO (Either Text Int64)
addNewItem = undefined