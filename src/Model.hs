{-# LANGUAGE OverloadedStrings #-}
module Model (
    ItemId, Item(..), ItemAvailability(..)
) where

import           Data.Text

type ItemId = Integer

data Item = Item { itemId      :: ItemId,
                   name        :: Text,
                   description :: Text,
                   quantity    :: Integer }
    deriving (Eq, Show)

data ItemAvailability = DoesNotExists | NotAvailable | Exists Item
    deriving (Eq, Show)

-- TODO : an item does not have a quantity by itself
--        represent the quantity only when the item is available
-- type Quantity = Integer
-- data ItemAvailability = DoesNotExists | NotAvailable | Exists Item Quantity
--     deriving (Eq, Show)
