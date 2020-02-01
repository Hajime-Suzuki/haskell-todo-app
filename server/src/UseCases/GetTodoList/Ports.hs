module UseCases.GetTodoList.Ports where
import           Network.AWS.Env

data GetTodoListUseCasePayload = GetTodoListUseCasePayload {
  env:: Env
}
