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
