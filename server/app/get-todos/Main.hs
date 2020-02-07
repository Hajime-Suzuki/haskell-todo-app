module Main where
import           UseCases.GetTodoList.UseCase
import           UseCases.GetTodoList.Ports
import           Utils.Database
import           Utils.APIGateway
import           Domain.Todo
import           Control.Lens
import           AWSLambda.Events.APIGateway
import           Data.Text                      ( Text )
import           Data.Aeson.Embedded
import           Data.Aeson                     ( encode )
import           Text.Pretty.Simple             ( pPrint )
import           Fake.GatewayReq

-- main = handler fakeGatewayReq
main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest Text
  -> IO (APIGatewayProxyResponse (Embedded (Response GetTodoListUseCaseRes)))

handler evt = do
  env <- getDbEnv
  let payload = GetTodoListUseCasePayload env
  res <- getTodoListUseCase payload
  return $ responseOK & responseBodyEmbedded ?~ Success res
