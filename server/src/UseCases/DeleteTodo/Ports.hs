

module UseCases.DeleteTodo.Ports where
import           Network.AWS.Env                ( Env )
import           Data.Text                      ( Text )
import           Domain.Todo
import           GHC.Generics
import           Data.Aeson

data DeleteTodoUseCasePayload = DeleteTodoUseCasePayload {
  _env :: Env,
  _todoId :: Text
}
