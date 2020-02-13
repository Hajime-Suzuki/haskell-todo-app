module UseCases.UpdateTodo.UseCase where

import qualified UseCases.UpdateTodo.Ports     as Ports
import           Repositories.Todos.UpdateTodo

updateTodoUseCase :: Ports.UpdateTodoUseCasePayload -> IO ()
updateTodoUseCase (Ports.UpdateTodoUseCasePayload env id input) =
  updateTodo env id input

