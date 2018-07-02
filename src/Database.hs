{-# LANGUAGE OverloadedStrings #-}
module Database (
    Item(..), ItemId, ItemAvailability,
    findItemById
) where

import           Control.Applicative
import           Control.Monad
import           Data.Maybe
import           Data.Monoid
import           Data.Text
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.FromField
import           Database.PostgreSQL.Simple.FromRow

import           Item

instance FromRow Item where
    fromRow = Item <$> field <*> field <*> field

instance FromRow Stock where
    fromRow = Stock <$> liftM3 Item field field field <*> field

findItemById :: ItemId -> IO ItemAvailability
findItemById id = do
    conn <- connectPostgreSQL "host=127.0.0.1 dbname=haskell_clean_archi_for_free user=haskell_clean_archi_for_free password=haskell_clean_archi_for_free"
    stock <- query conn "select id, name, description, quantity from item where id=?" [id]
    case stock of
        [Stock item qt] ->
            if qt > 0
                then return $ Available item
                else return NotAvailable
        [] -> return DoesNotExists
