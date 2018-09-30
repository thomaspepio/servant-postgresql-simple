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

instance FromRow Item where
    fromRow = Item <$> field <*> field <*> field

instance FromRow Stock where
    fromRow = Stock <$> liftM3 Item field field field <*> field

connection :: IO Connection
connection = do
    (Config dbhost dbuser dbpassword dbname) <- readConfiguration
    connect defaultConnectInfo {
        connectHost = dbhost,
        connectPort = 5432,
        connectUser = dbuser,
        connectPassword = dbpassword,
        connectDatabase = dbname
    }

findItemById :: ItemId -> IO ItemAvailability
findItemById id = do
    conn <- liftIO connection
    stock <- query conn "select id, name, description, quantity from item where id=?" [id]
    case stock of
        [Stock item qt] ->
            if qt > 0
                then return $ Available item
                else return NotAvailable
        [] -> return DoesNotExists

findItemByNameAndDescription :: Item -> IO ItemAvailability
findItemByNameAndDescription (Item _ name desc) = do
    conn <- liftIO connection
    item <- query conn "select id, name, description from item where name=? and description=?" [name, desc]
    case item of
        [i] -> return $ Available i
        []  -> return $ DoesNotExists

addNewItem :: Item -> IO (Either Text Int64)
addNewItem (Item id name desc) = do
    conn <- liftIO connection
    itemExists <- findItemByNameAndDescription (Item id name desc)
    case itemExists of
        DoesNotExists -> do
            nbRows <- execute conn "insert into item(name, description, quantity) values(?, ?, 0)" [name, desc]
            return $ Right nbRows
        _ -> return $ Left "Item already exists"