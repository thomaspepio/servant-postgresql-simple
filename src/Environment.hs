module Environment (
    Config(..),
    readConfiguration
) where

import           Control.Monad.Trans.Reader
import           System.Environment

data Config = Config { dbhost     :: String,
                       dbuser     :: String,
                       dbpassword :: String,
                       dbname     :: String
              } deriving (Eq, Show)

readConfiguration :: IO Config
readConfiguration = do
    host     <- lookupEnv "DB_HOST"
    user     <- lookupEnv "DB_USER"
    password <- lookupEnv "DB_PASSWORD"
    name     <- lookupEnv "DB_NAME"
    case (host, user, password, name) of
        (Just dbhost, Just dbuser, Just dbpassword, Just dbname) -> return $ Config dbhost dbuser dbpassword dbname
        (Nothing, Nothing, Nothing, Nothing)                     -> return $ Config "127.0.0.1" "haskell_clean_archi_for_free" "haskell_clean_archi_for_free" "haskell_clean_archi_for_free"
        (Nothing, _, _, _)                                       -> error "DB_HOST environment variable is not set"
        (_, Nothing, _, _)                                       -> error "DB_USER environment variable is not set"
        (_, _, Nothing, _)                                       -> error "DB_PASSWORD environment variable is not set"
        (_, _, _, Nothing)                                       -> error "DB_NAME environment variable is not set"
