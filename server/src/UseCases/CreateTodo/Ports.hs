{-# LANGUAGE DeriveGeneric, TemplateHaskell #-}

module UseCases.CreateTodo.Ports where
import qualified Domain.Todo                   as Todo
import           GHC.Generics
import           Data.Aeson
import           Text.Casing                    ( camel )
import           Control.Lens
import           Network.AWS.Env                ( Env )

data CreateTodoUseCasePayload = CreateTodoUseCasePayload {
  env :: Env,
  createTodoInput :: CreateTodoInput
}


newtype CreateTodoInput = CreateTodoInput {
  _inputTitle :: String
}deriving(Generic, Show)

instance FromJSON CreateTodoInput where
  parseJSON =
    genericParseJSON defaultOptions { fieldLabelModifier = drop 6 . camel }

makeLenses ''CreateTodoInput


newtype CreateTodoUseCaseRes = CreateTodoUseCaseRes {
  _todo :: Todo.Todo
}deriving(Generic, Show)

instance ToJSON CreateTodoUseCaseRes where
  toJSON = genericToJSON defaultOptions { fieldLabelModifier = drop 1 }
