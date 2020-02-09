{-# LANGUAGE OverloadedStrings#-}
module Main where

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
import           UseCases.DeleteTodo.UseCase
import           UseCases.DeleteTodo.Ports

main = handler $ fakeGatewayReq
-- main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse (Embedded Text))

handler evt = do
  env <- getDbEnv
  deleteTodoUseCase $ DeleteTodoUseCasePayload env "1"
  return $ responseOK & responseBodyEmbedded ?~ "delete user"
