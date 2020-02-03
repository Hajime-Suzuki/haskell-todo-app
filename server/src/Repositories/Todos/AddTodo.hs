{-# LANGUAGE OverloadedStrings #-}

module Repositories.Todos.AddTodo where

import           Data.Text                      ( Text )
import           Network.AWS.DynamoDB
import           Control.Lens
import           Control.Monad.Trans.AWS
import           Network.AWS                    ( runAWS )
import qualified Data.HashMap.Strict           as HM
import           Data.Maybe                     ( fromJust
                                                , catMaybes
                                                , mapMaybe
                                                )
import           Domain.Todo
import           Debug.Trace                    ( trace )
import           Repositories.Todos.Transform
import           Utils.Database
import           Text.Pretty.Simple


addTodo :: Env -> Todo -> IO ()
addTodo env todo = do
  res <- runResourceT . runAWS env . send $ req
  pPrint $ res ^. pirsResponseStatus
  where req = putItem dbName & piItem .~ toDbEntity todo

