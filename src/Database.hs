{-# LANGUAGE OverloadedStrings #-}
module Database (
    Item(..), ItemId, ItemAvailability,
    findItem
) where

import           Control.Applicative
import           Control.Monad
import           Data.Maybe
import           Data.Monoid
import           Data.Text
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.FromField
import           Database.PostgreSQL.Simple.FromRow

import           Model

instance FromRow Item where
    fromRow = Item <$> field <*> field <*> field

findItem :: ItemId -> IO ItemAvailability
findItem id = do
    conn <- connectPostgreSQL "host=127.0.0.1 dbname=haskell_clean_archi_for_free user=haskell_clean_archi_for_free password=haskell_clean_archi_for_free"
    i <- query conn "select id, name, description from item where id=?" [id]
    case i of
        [item] -> return $ Exists item
        []     -> return DoesNotExists
