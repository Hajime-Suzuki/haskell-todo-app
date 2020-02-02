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
import           Fake.GatewayReq
import           Text.Pretty.Simple             ( pPrint )

main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest Text
  -> IO
       (APIGatewayProxyResponse (Embedded (Response GetTodoListUserCaseRes)))

handler evt = do
  env <- getDbEnv
  let payload = GetTodoListUseCasePayload env
  res <- getTodoListUseCase payload
  return $ responseOK & responseBodyEmbedded ?~ Success res
