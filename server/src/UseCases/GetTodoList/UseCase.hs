{-# LANGUAGE OverloadedStrings #-}
module UseCases.GetTodoList.UseCase where

import           UseCases.GetTodoList.Ports
import           Domain.Todo

getTodoListUseCase :: GetTodoListUseCasePayload -> Maybe [Todo]
getTodoListUseCase paylod =
  pure $ [createTodo $ CreateTodoInput "test" "asht" "asht"]
