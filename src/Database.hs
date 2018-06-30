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

data ItemAvailability = DoesNotExists | NotAvailable | Exists Item
    deriving (Eq, Show)

findItem :: ItemId -> IO ItemAvailability
findItem id = do
    conn <- connectPostgreSQL "host=127.0.0.1 dbname=haskell_test user=haskell_test password=haskell_test"
    i <- query conn "select id, name, description from item where id=?" [id]
    case i of
        [item] -> return $ Exists item
        []     -> return DoesNotExists
