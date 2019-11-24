{-# LANGUAGE TemplateHaskell #-}
module Cat.QuoteExternalDec (cat) where

import System.IO.Unsafe (unsafePerformIO)
import System.IO
import System.Environment

import qualified Language.Haskell.TH as TH
import Language.Haskell.TH (Q, Exp, Dec)
import Language.Haskell.TH.Quote (QuasiQuoter(..))

import Cat.Parser (catParse)
import Cat.CodeGenDec (catCodeGen)
import Control.Monad (when)

cat :: QuasiQuoter
cat = QuasiQuoter (error "parse expression")
                  (error "parse pattern")
                  (error "parse type")
                  getFileAndCompile

parseAndGenCode :: String -> Q [Dec]
parseAndGenCode input = do
  loc <- TH.location
  let fileName = TH.loc_filename loc
  let (line, column) = TH.loc_start loc

  case catParse fileName line column input of
    Left err -> unsafePerformIO $ fail $ show err
    Right x  -> catCodeGen x


getFileAndCompile :: String -> Q [Dec]
getFileAndCompile _ = do
  maybeArgs <- TH.runIO $ lookupEnv "CAT_FILE"
  case maybeArgs of
    Just filename -> do
      when (filename == "") (fail "No file")
      program <- TH.runIO $ readFile filename
      parseAndGenCode program
    Nothing -> fail "Wrong number of arguments"