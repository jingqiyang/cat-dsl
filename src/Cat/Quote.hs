{-# LANGUAGE TemplateHaskell #-}
module Cat.Quote (cat) where

import System.IO.Unsafe (unsafePerformIO)
import System.IO
import System.Environment

import qualified Language.Haskell.TH as TH
import Language.Haskell.TH (Q, Exp, Dec)
import Language.Haskell.TH.Quote (QuasiQuoter(..))

import Cat.Parser (catParse)
import Cat.CodeGen (catCodeGen)
import Control.Monad (when)

cat :: QuasiQuoter
cat = QuasiQuoter parseAndGenCode
                  (error "parse pattern")
                  (error "parse type")
                  (error "parse declaration")

parseAndGenCode :: String -> Q Exp
parseAndGenCode input = do
  loc <- TH.location
  let fileName = TH.loc_filename loc
  let (line, column) = TH.loc_start loc

  case catParse fileName line column input of
    Left err -> unsafePerformIO $ fail $ show err
    Right x  -> catCodeGen x
