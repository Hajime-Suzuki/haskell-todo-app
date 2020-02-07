{-# LANGUAGE OverloadedStrings#-}
module Main where
import           UseCases.CreateTodo.Ports
import           UseCases.CreateTodo.UseCase
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


-- main = handler $ createFakeReq (CreateTodoInput "id" "title" "2020-01-01") []
main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest (Embedded CreateTodoInput)
  -> IO (APIGatewayProxyResponse (Embedded Text))

handler evt = do
  let body = evt ^. requestBodyEmbedded
  env <- getDbEnv
  case body of
    Nothing ->
      return
        $  responseBadRequest
        &  responseBodyEmbedded
        ?~ "input can not be empty"
    (Just body) -> do
      todo <- createTodoUseCase $ CreateTodoUseCasePayload env body
      return $ responseOK & responseBodyEmbedded ?~ "create user test"
