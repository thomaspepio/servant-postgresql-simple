{-# LANGUAGE OverloadedStrings #-}
module Model where

import           Data.Text

type ItemId = Integer

data Item = Item { itemId      :: ItemId,
                   name        :: Text,
                   description :: Text }
    deriving (Eq, Show)
