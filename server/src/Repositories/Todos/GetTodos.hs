module Repositories.Todos.GetTodos where

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


getAllTodos :: Env -> IO [Todo]
getAllTodos env = do
  res <- runResourceT . runAWS env . send =<< req
  return $ mapMaybe fromDbEntity $ res ^. srsItems
 where
  req = do
    dbName <- getDbName
    return $ scan dbName



