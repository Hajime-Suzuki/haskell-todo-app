{-# LANGUAGE DeriveGeneric #-}

module UseCases.GetTodoList.Ports where
import           Network.AWS.Env                ( Env )
import           Domain.Todo
import           GHC.Generics
import           Data.Aeson

data GetTodoListUseCasePayload = GetTodoListUseCasePayload {
  _env :: Env
}

data GetTodoListUserCaseRes = GetTodoListUserCaseRes {
  _todos :: [Todo]
}deriving(Generic, Show)

instance ToJSON GetTodoListUserCaseRes where
  toJSON = genericToJSON defaultOptions { fieldLabelModifier = drop 1 }
