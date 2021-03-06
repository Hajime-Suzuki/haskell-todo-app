{-# LANGUAGE DeriveGeneric #-}

module UseCases.UpdateTodo.Ports where
import           Network.AWS.Env                ( Env )
import           Data.Text                      ( Text )
import           Domain.Todo
import           GHC.Generics
import           Data.Aeson
import           Text.Casing                    ( camel )


data UpdateTodoUseCasePayload = UpdateTodoUseCasePayload {
  _env :: Env,
  _todoId :: Text,
  _input :: UpdateTodoInput
}

data UpdateTodoInput = UpdateTodoInput {
  _updateInputTitle :: Maybe Text,
  _updateInputDone :: Maybe Bool
} deriving(Show, Generic)

instance FromJSON UpdateTodoInput where
  parseJSON =
    genericParseJSON defaultOptions { fieldLabelModifier = camel . drop 12 }

