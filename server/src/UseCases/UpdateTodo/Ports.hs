

module UseCases.UpdateTodo.Ports where
import           Network.AWS.Env                ( Env )
import           Data.Text                      ( Text )
import           Domain.Todo
import           GHC.Generics
import           Data.Aeson

data UpdateTodoUseCasePayload = UpdateTodoUseCasePayload {
  _env :: Env,
  _todoId :: Text,
  _input :: UpdateTodoInput
}

data UpdateTodoInput = UpdateTodoInput {
  _updateInputTitle :: Maybe Text,
  _updateInputDone :: Maybe Bool
} deriving(Show)
