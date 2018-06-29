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

type ItemId = Integer

data Item = Item { itemId      :: ItemId,
                   name        :: Text,
                   description :: Text }
    deriving (Eq, Show)

instance FromRow Item where
    fromRow = Item <$> field <*> field <*> field

data ItemAvailability = DoesNotExists | NotAvailable | Exists Item
    deriving (Eq, Show)

findItem :: IO Text
findItem = do
    conn <- connectPostgreSQL "host=127.0.0.1 dbname=haskell_test user=haskell_test password=haskell_test"
    [Only i] <- query_ conn "select name from item where id=1"
    return i
