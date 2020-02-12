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

-- main = apiGatewayMain handler
main =
  handler $ createFakeReq (UpdateTodoInput (Just "updated") (Just True)) []

handler
  :: APIGatewayProxyRequest (Embedded UpdateTodoInput)
  -> IO (APIGatewayProxyResponse (Embedded Text))

handler evt = do
  env <- getDbEnv
  let body = evt ^. requestBodyEmbedded
  case body of
    Nothing ->
      return
        $  responseBadRequest
        &  responseBodyEmbedded
        ?~ "body can not be empty"
    (Just b) -> do
      updateTodoUseCase $ UpdateTodoUseCasePayload env "1" b
      return $ responseOK & responseBodyEmbedded ?~ "update todo"
