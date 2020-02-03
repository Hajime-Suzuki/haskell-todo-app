{-# LANGUAGE OverloadedStrings #-}

module Repositories.Todos.Transform where

import           Data.Text                      ( Text )
import           Control.Lens
import           Control.Monad.Trans.AWS
import qualified Data.HashMap.Strict           as HM
import           Data.Maybe                     ( fromJust )
import           Domain.Todo
import           Network.AWS.DynamoDB

fromDbEntity :: HM.HashMap Text AttributeValue -> Maybe Todo
fromDbEntity item = if null item
  then Nothing
  else Just Todo { _todoId        = fromJust $ item ^. ix "id" . avS
                 , _todoTitle     = fromJust $ item ^. ix "title" . avS
                 , _todoCreatedAt = fromJust $ item ^. ix "createdAt" . avS
                 , _todoDone = fromJust . fromJust $ item ^? ix "done" . avBOOL -- check why item ^. ix "done" . avBOOL does not work
                 }

toDbEntity :: Todo -> HM.HashMap Text AttributeValue
toDbEntity todo = HM.fromList
  [ ("id"       , attributeValue & avS ?~ (todo ^. todoId))
  , ("title"    , attributeValue & avS ?~ (todo ^. todoTitle))
  , ("createdAt", attributeValue & avS ?~ (todo ^. todoCreatedAt))
  , ("done"     , attributeValue & avBOOL ?~ (todo ^. todoDone))
  ]
