{-# LANGUAGE OverloadedStrings #-}

module Repositories.Todos.UpdateTodo where

import           Data.Text                      ( Text
                                                , pack
                                                )
import           Network.AWS.DynamoDB
import           Control.Lens
import           Control.Monad.Trans.AWS
import           Network.AWS                    ( runAWS )
import qualified Data.HashMap.Strict           as HM
import           Data.Maybe                     ( fromJust
                                                , catMaybes
                                                , mapMaybe
                                                , isJust
                                                )
import           Data.List                      ( intercalate )
import           Domain.Todo
import           Debug.Trace                    ( trace )
import           Repositories.Todos.Transform
import           Utils.Database
import           Text.Pretty.Simple
import           UseCases.UpdateTodo.Ports


type Id = Text
updateTodo :: Env -> Id -> UpdateTodoInput -> IO ()
updateTodo env id input = do
  res <- runResourceT . runAWS env . send $ req
  print res
 where
  req =
    updateItem dbName
      &  uiKey
      .~ key
      &  uiUpdateExpression
      ?~ expr
      &  uiExpressionAttributeValues
      .~ values
  key    = HM.fromList [("id", attributeValue & avS ?~ id)]
  expr   = getUpdateUserExpression input
  values = getUpdateUserExpressionValues input


--TODO: improve dynamic update

getUpdateUserExpression :: UpdateTodoInput -> Text
getUpdateUserExpression input = pack $ "SET " ++ intercalate
  ", "
  (filter (not . null) [fn, ln])
 where
  fn = if isJust (_updateInputTitle input) then "title = :updatedTitle" else ""
  ln = if isJust (_updateInputDone input) then "done = :updatedDone" else ""


getUpdateUserExpressionValues
  :: UpdateTodoInput -> HM.HashMap Text AttributeValue
getUpdateUserExpressionValues = filterMap . getValues

filterMap :: HM.HashMap Text AttributeValue -> HM.HashMap Text AttributeValue
filterMap = HM.filterWithKey helper
 where
  helper ":updatedTitle" v = isJust (v ^. avS)
  helper ":updatedDone"  v = isJust (v ^. avBOOL)

getValues :: UpdateTodoInput -> HM.HashMap Text AttributeValue
getValues input =
  HM.empty
    &  at ":updatedTitle"
    ?~ (attributeValue & avS .~ _updateInputTitle input)

    &  at ":updatedDone"
    ?~ (attributeValue & avBOOL .~ _updateInputDone input)
