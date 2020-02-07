module UseCases.CreateTodo.UseCase where

import           UseCases.CreateTodo.Ports
import           Repositories.Todos.AddTodo
import           Domain.Todo
import           Data.Maybe                     ( catMaybes )
import           Text.Pretty.Simple

createTodoUseCase :: CreateTodoUseCasePayload -> IO CreateTodoUseCaseRes
createTodoUseCase (CreateTodoUseCasePayload env createTodoInput) = do
  let todo = createTodo createTodoInput
  addTodo env todo
  return $ CreateTodoUseCaseRes todo

