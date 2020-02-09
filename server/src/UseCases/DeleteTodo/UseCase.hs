module UseCases.DeleteTodo.UseCase where

import qualified UseCases.DeleteTodo.Ports     as Ports
import           Repositories.Todos.DeleteTodo
import           Domain.Todo
import           Data.Maybe                     ( catMaybes )

deleteTodoUseCase :: Ports.DeleteTodoUseCasePayload -> IO ()
deleteTodoUseCase payload = do
  deleteTodo (Ports._env payload) (Ports._todoId payload)

