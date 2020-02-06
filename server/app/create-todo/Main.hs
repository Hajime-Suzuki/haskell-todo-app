{-# LANGUAGE OverloadedStrings#-}
module Main where
import           UseCases.CreateTodo.Ports
import           Utils.Database
import           Utils.APIGateway
import           Control.Lens
import           AWSLambda.Events.APIGateway
import           Data.Text                      ( Text )
import           Data.Aeson.Embedded
import           Data.Aeson                     ( encode )
import           Fake.GatewayReq
import           Text.Pretty.Simple             ( pPrint )

main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest (Embedded CreateTodoInput)
  -> IO (APIGatewayProxyResponse (Embedded Text))

handler evt = do
  env <- getDbEnv
  return $ responseOK & responseBodyEmbedded ?~ "create user test"
