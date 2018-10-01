{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Environment (
    Config(..),
    readConfiguration
) where

import           Prelude hiding(concat)

import           Data.Monoid
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Except
import           Data.Text
import           System.Environment

data Config = Config { dbhost     :: Text,
                       dbuser     :: Text,
                       dbpassword :: Text,
                       dbname     :: Text
              } deriving (Eq, Show)

type ConfigurationError = Text
type ConfigurationLookup a = ExceptT ConfigurationError IO a

defaultConfig :: Config
defaultConfig = Config "127.0.0.1" "haskell_servant_postgresql_simple" "haskell_servant_postgresql_simple" "haskell_servant_postgresql_simple"

readConfiguration :: IO Config
readConfiguration = do
    lookedUp <- runExceptT lookupConfiguration
    return $ either (const defaultConfig) id lookedUp

lookupConfiguration :: ConfigurationLookup Config
lookupConfiguration = do
    host     <- lookupEnvVar "DB_HOST"
    user     <- lookupEnvVar "DB_USER"
    password <- lookupEnvVar "DB_PASSWORD"
    name     <- lookupEnvVar "DB_NAME"
    return $ Config host user password name

lookupEnvVar :: Text -> ConfigurationLookup Text
lookupEnvVar var = do
    host <- liftIO $ lookupEnv (unpack var)
    case host of
        Just h  -> return $ pack h
        Nothing -> throwE $ "Environment variable " <> var <> " is missing"
