{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Endpoints where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.Trans.Either
import           Data.Aeson
import           Data.Aeson.Types
import           Data.ByteString
import           Data.Proxy
import           Servant.API

import           Database
import           Model

type ItemAPI =
    -- GET /item/:id
    "item" :> Capture "id" Integer :> Get '[JSON] [Item]

api :: Proxy ItemAPI
api = Proxy

server :: Server ItemAPI
server = getItem

-- This is Servant's default handler type.
type Handler a = EitherT ServantErr IO a

getItem :: Handler Item
getItem id = do
    item <- findItem id
    case item of
        DoesNotExists -> left err404
        NotAvailable  -> left err500
        Item i        -> i


instance FromJSON Item where
    parseJSON = withObject "Item" $ \i -> Item
        <$> i .: "id"
        <*> i .: "name"
        <*> i .: "description"

instance ToJSON Item where
    toJSON (Item id name desc) = object [ "id" .= id, "name" .= name, "description" .= desc ]
