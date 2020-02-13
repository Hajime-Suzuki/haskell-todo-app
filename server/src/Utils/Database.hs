{-# LANGUAGE OverloadedStrings #-}

module Utils.Database where

import           Network.AWS.Auth
import           Network.AWS.Types
import           Network.AWS.Env
import           Network.AWS
import           Network.AWS.DynamoDB           ( dynamoDB )
import           Control.Lens
import           Control.Applicative            ( (<|>) )
import           System.Environment             ( lookupEnv )
import           Data.Maybe                     ( isJust
                                                , fromJust
                                                )
import           Data.Text
import           Text.Pretty.Simple
import           System.IO                      ( stdout )

getDbEnv :: IO Env
getDbEnv = do
  isOffline <- lookupEnv "IS_OFFLINE"
  logger    <- newLogger Debug stdout
  case isOffline of
    Nothing ->
      newEnv Discover <&> envRegion .~ Frankfurt <&> envLogger .~ logger
    (Just _) -> do
      let dynamo = setEndpoint False "localhost" 8000 dynamoDB
      newEnv Discover
        <&> configure dynamo
        <&> envRegion
        .~  Frankfurt
        <&> envLogger
        .~  logger

getDbName :: IO Text
getDbName = do
  dbName <- lookupEnv "dbName"
  case dbName of
    (Just x) -> return $ pack x
    Nothing  -> return "haskell-todo-app-db"


