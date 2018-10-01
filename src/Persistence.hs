{-# LANGUAGE OverloadedStrings #-}
module Persistence (
    Item(..), ItemId,
    findItemById, findItemByNameAndDescription, addNewItem
) where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import           Data.ByteString                      hiding (putStrLn, unpack)
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
    (Config dbhost dbuser dbpassword dbname) <- readConfiguration
    connect defaultConnectInfo {
        connectHost = unpack dbhost,
        connectPort = 5432,
        connectUser = unpack dbuser,
        connectPassword = unpack dbpassword,
        connectDatabase = unpack dbname
    }

findItemById :: ItemId -> IO (Availability Item)
findItemById id = 
    findItemGivenParams (Item id "" "") ("select id, name, description, quantity from item where id=?", [id])

findItemByNameAndDescription :: Item -> IO (Availability Item)
findItemByNameAndDescription (Item id name desc) = 
    findItemGivenParams (Item id name desc) ("select id, name, description, quantity from item where name=? and description=?", [name, desc])

findItemGivenParams :: ToRow q => Item -> (Query, q) -> IO (Availability Item)
findItemGivenParams item (sqlQuery, params) = do
    conn <- connection
    item <- query conn sqlQuery params
    maybe invalidPrimaryKeyConstraint return $ checkAvailability item

addNewItem :: Item -> IO (Either Text Int64)
addNewItem (Item id name desc) = do
    conn <- liftIO connection
    itemExists <- findItemByNameAndDescription (Item id name desc)
    case itemExists of
        Unknown -> do
            nbRows <- execute conn "insert into item(name, description, quantity) values(?, ?, 0)" [name, desc]
            return $ Right nbRows
        _ -> return $ Left "Item already exists"

checkAvailability :: [Stock] -> Maybe (Availability Item)
checkAvailability [Stock _ 0]  = Just NotAvailable
checkAvailability [Stock i qt] = Just $ Available i
checkAvailability []           = Just Unknown
checkAvailability _            = Nothing

invalidPrimaryKeyConstraint = error "invalid primary key constraint on Item"