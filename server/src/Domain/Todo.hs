{-# LANGUAGE OverloadedStrings, TemplateHaskell, DeriveAnyClass, DeriveGeneric #-}

module Domain.Todo where

import           Data.Text                      ( Text )
import           Control.Lens
import           GHC.Generics
import           Data.Aeson
import           Text.Casing                    ( camel )
import           Debug.Pretty.Simple
type ID = Text

data Todo = Todo {
  _todoId :: ID,
  _todoTitle :: Text,
  _todoCreatedAt :: Text,
  _todoDone :: Bool
} deriving(Generic, Show)

instance ToJSON Todo where
  toJSON = genericToJSON defaultOptions { fieldLabelModifier = camel . drop 5 }

makeLenses ''Todo


data CreateTodoInput = CreateTodoInput {
  _todoInputId :: Text,
  _todoInputTitle :: Text,
  _todoInputCreatedAt :: Text
}deriving(Show, Generic)


instance FromJSON CreateTodoInput where
  parseJSON =
    genericParseJSON defaultOptions { fieldLabelModifier = camel . drop 10 }

makeLenses ''CreateTodoInput

createTodo :: CreateTodoInput -> Todo
createTodo input = Todo { _todoId        = _todoInputId input
                        , _todoTitle     = _todoInputTitle input
                        , _todoCreatedAt = _todoInputCreatedAt input
                        , _todoDone      = False
                        }

