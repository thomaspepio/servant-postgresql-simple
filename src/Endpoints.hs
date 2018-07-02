{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Endpoints where

import           Control.Applicative
import           Control.Monad
import           Data.Aeson
import           Data.Aeson.Types
import           Data.ByteString
import           Servant.API

import           Model

type ItemAPI = "item" :> Get '[JSON] [Item]

instance FromJSON Item where
    parseJSON = withObject "Item" $ \i -> Item
        <$> i .: "id"
        <*> i .: "name"
        <*> i .: "description"

instance ToJSON Item where
    toJSON (Item id name desc) = object [ "id" .= id, "name" .= name, "description" .= desc ]
