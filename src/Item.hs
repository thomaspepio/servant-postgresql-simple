module Item (
    ItemId, Item(..), Availability(..), Stock(..),
    addStock, removeStock
) where

import           Data.Text

type ItemId = Integer

data Item = Item { itemId      :: ItemId,
                   name        :: Text,
                   description :: Text }
    deriving (Eq, Show)

data Availability a = Available a | NotAvailable | Unknown
    deriving (Eq, Show)

data Stock = Stock { item     :: Item,
                     quantity :: Integer }
    deriving (Eq, Show)

addStock :: Integer -> Stock -> Stock
addStock toAdd (Stock i qt) = Stock i (qt + toAdd)

removeStock :: Integer -> Stock -> Stock
removeStock toRemove (Stock i qt)
    | qt - toRemove < 0 = Stock i 0
    | otherwise         = Stock i (qt - toRemove)
