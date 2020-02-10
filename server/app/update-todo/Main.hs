{-# LANGUAGE OverloadedStrings#-}
module Main where
import           UseCases.UpdateTodo.Ports
import           UseCases.UpdateTodo.UseCase
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

main = handler fakeGatewayReq

handler
  :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse (Embedded Text))

handler evt = do
  env <- getDbEnv
  let input = UpdateTodoInput "updated" True
  updateTodoUseCase $ UpdateTodoUseCasePayload env "1" input
  return $ responseOK & responseBodyEmbedded ?~ "update todo"
