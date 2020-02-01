module Main where
import           UseCases.GetTodoList.UseCase
import           UseCases.GetTodoList.Ports
import           Utils.Database

main = do
  env <- getDbEnv
  let payload = GetTodoListUseCasePayload env
  let todos   = getTodoListUseCase payload
  print todos
