{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Endpoints (
    -- application
) where

import           Control.Monad.IO.Class
import           Control.Monad.Trans.Except
import           Data.Aeson
import           Data.ByteString
import           Database.PostgreSQL.Simple
import           Servant

import           Item
import           Persistence

-- type ItemAPI =
--           "item" :> Capture "id" Integer :> Get '[JSON] Item     -- GET /item/:id
--     :<|> "item" :> ReqBody '[JSON] Item :> Post '[JSON] ItemId  -- POST /item

-- itemAPI :: Proxy ItemAPI
-- itemAPI = Proxy

-- server :: Server ItemAPI
-- server = getItem 
-- :<|> postItem

-- getItem :: Integer -> Handler Item
-- getItem = undefined

-- postItem :: Item -> Handler ItemId
-- postItem = undefined

-- application :: Application
-- application = serve itemAPI server
