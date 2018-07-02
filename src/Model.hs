{-# LANGUAGE OverloadedStrings #-}
module Model where

import           Data.Text

type ItemId = Integer

data Item = Item { itemId      :: ItemId,
                   name        :: Text,
                   description :: Text }
    deriving (Eq, Show)


data ItemAvailability = DoesNotExists | NotAvailable | Exists Item
    deriving (Eq, Show)
