module UseCases.GetTodoList.UseCase where

import           UseCases.GetTodoList.Ports
import           Domain.Todo
import           Repositories.Todos.GetTodos
import           Data.Maybe                     ( catMaybes )

getTodoListUseCase :: GetTodoListUseCasePayload -> IO GetTodoListUserCaseRes
getTodoListUseCase payload = do
  todos <- getAllTodos $ _env payload
  return $ GetTodoListUserCaseRes todos


