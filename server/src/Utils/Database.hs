{-# LANGUAGE OverloadedStrings #-}

module Utils.Database where

import           Network.AWS.Auth
import           Network.AWS.Types
import           Network.AWS.Env
import           Network.AWS                    ( setEndpoint )
import           Network.AWS.DynamoDB           ( dynamoDB )
import           Control.Lens
import           System.Environment             ( lookupEnv )
import           Data.Maybe                     ( isJust )
import           Data.Text
getDbEnv :: IO Env
getDbEnv = do
  isOffline <- lookupEnv "IS_OFFLINE"
  case isOffline of
    Nothing  -> newEnv Discover <&> envRegion .~ Frankfurt
    (Just _) -> do
      let dynamo = setEndpoint False "localhost" 8000 dynamoDB
      newEnv Discover <&> configure dynamo <&> envRegion .~ Frankfurt

dbName :: Text
dbName = "haskell-todo-app"
