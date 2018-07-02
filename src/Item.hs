{-# LANGUAGE OverloadedStrings #-}
module Item (
    ItemId, Item(..), ItemAvailability(..), Stock(..),
    addStock, removeStock
) where

import           Data.Text

type ItemId = Integer

data Item = Item { itemId      :: ItemId,
                   name        :: Text,
                   description :: Text }
    deriving (Eq, Show)

data ItemAvailability = DoesNotExists | NotAvailable | Exists Item
    deriving (Eq, Show)

data Stock = Stock { item     :: Item,
                     quantity :: Integer }
    deriving (Eq, Show)

addStock :: Integer -> Stock -> Stock
addStock toAdd (Stock i qt) = Stock { item = i, quantity = qt + toAdd }

removeStock :: Integer -> Stock -> Stock
removeStock toRemove (Stock i qt)
    | qt - toRemove < 0 = Stock { item = i, quantity = 0 }
    | otherwise = Stock { item = i, quantity = qt - toRemove }
