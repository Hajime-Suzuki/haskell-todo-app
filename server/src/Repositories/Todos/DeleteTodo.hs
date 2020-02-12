{-# LANGUAGE OverloadedStrings #-}

module Repositories.Todos.DeleteTodo where

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

type Id = Text

deleteTodo :: Env -> Id -> IO ()
deleteTodo env id = do
  res <- runResourceT . runAWS env . send =<< req
  print $ "todo" ++ show id ++ "has been deleted"
 where
  req = do
    dbName <- getDbName
    return $ deleteItem dbName & diKey .~ HM.fromList
      [("id", attributeValue & avS ?~ id)]


