{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Endpoints (
    application
) where

import           Control.Monad.IO.Class
import           Control.Monad.Trans.Except
import           Data.Aeson
import           Data.ByteString
import           Database.PostgreSQL.Simple
import           Servant

import           Item
import           Persistence

type ItemAPI =
         "item" :> Capture "id" Integer :> Get '[JSON] Item     -- GET /item/:id
    :<|> "item" :> ReqBody '[JSON] Item :> Post '[JSON] ItemId  -- POST /item

itemAPI :: Proxy ItemAPI
itemAPI = Proxy

server :: Server ItemAPI
server = getItem 
    :<|> postItem
    where
        getItem :: Integer -> Handler Item
        getItem id = do
            item <- liftIO $ findItemById id
            case item of
                DoesNotExists -> throwError $ err404 { errBody = "This item does not exists" }
                NotAvailable  -> throwError $ err404 { errBody = "This item is not in stock" }
                Available i      -> return i
        postItem :: Item -> Handler ItemId
        postItem itemToPost = do
            newItem <- liftIO $ addNewItem itemToPost
            case newItem of
                Right _  -> return 1 -- TODO : return the ID of the new item instead (is ItemAvailability a good design choice ?)
                Left err -> throwError $ err400 { errBody = "This item already exists" }

application :: Application
application = serve itemAPI server

instance FromJSON Item where
    parseJSON = withObject "Item" $ \i -> Item
        <$> i .: "id"
        <*> i .: "name"
        <*> i .: "description"

instance ToJSON Item where
    toJSON (Item id name desc) = object [ "id" .= id, "name" .= name, "description" .= desc ]
