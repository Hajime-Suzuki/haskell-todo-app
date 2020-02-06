module UseCases.GetTodoList.UseCase where

import           UseCases.GetTodoList.Ports
import           Domain.Todo
import           Repositories.Todos.GetTodos
import           Data.Maybe                     ( catMaybes )

getTodoListUseCase :: GetTodoListUseCasePayload -> IO GetTodoListUseCaseRes
getTodoListUseCase payload = do
  todos <- getAllTodos $ _env payload
  return $ GetTodoListUseCaseRes todos


