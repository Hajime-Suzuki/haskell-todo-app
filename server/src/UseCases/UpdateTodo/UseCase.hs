module UseCases.UpdateTodo.UseCase where

import qualified UseCases.UpdateTodo.Ports     as Ports
import           Domain.Todo
import           Data.Maybe                     ( catMaybes )

updateTodoUseCase :: Ports.UpdateTodoUseCasePayload -> IO ()
updateTodoUseCase payload = do
  print "update"

