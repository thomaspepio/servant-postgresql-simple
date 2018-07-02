{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Endpoints (
    application
) where

import           Control.Monad.Trans.Except
import           Data.Aeson
import           Data.ByteString
import           Servant

import           Database
import           Model

type ItemAPI =
    -- GET /item/:id
    "item" :> Capture "id" Integer :> Get '[JSON] Item

itemAPI :: Proxy ItemAPI
itemAPI = Proxy

server :: Server ItemAPI
server = getItem
    where
        getItem :: Integer -> Handler Item
        getItem id = return Item { itemId = 0, name = "foo", description = "bar"}

application :: Application
application = serve itemAPI server

instance FromJSON Item where
    parseJSON = withObject "Item" $ \i -> Item
        <$> i .: "id"
        <*> i .: "name"
        <*> i .: "description"

instance ToJSON Item where
    toJSON (Item id name desc) = object [ "id" .= id, "name" .= name, "description" .= desc ]
