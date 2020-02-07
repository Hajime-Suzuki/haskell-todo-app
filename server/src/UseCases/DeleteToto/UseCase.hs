module UseCases.DeleteTodo.UseCase where

import           UseCases.DeleteTodo.Ports
import           Domain.Todo
import           Data.Maybe                     ( catMaybes )

deleteTodoUseCase :: DeleteTodoUseCasePayload -> IO ()
deleteTodoUseCase payload = do
  print "delete todo"
