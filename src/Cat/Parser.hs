{-# LANGUAGE DeriveDataTypeable, TemplateHaskell, ScopedTypeVariables, KindSignatures #-}
module Cat.Parser where

import Text.ParserCombinators.Parsec
import qualified Text.Parsec.String as PS
import qualified Text.Parsec.Prim   as PP
import qualified Text.Parsec.Token  as PT
import Text.ParserCombinators.Parsec.Language (haskellStyle, reservedOpNames, reservedNames)
import Text.ParserCombinators.Parsec.Pos      (newPos)

import Cat.Syntax

type Parser = PS.Parser

catParse :: SourceName -> Line -> Column -> String -> Either ParseError Cat
catParse fileName line column input
  = PP.parse (do { setPosition (newPos fileName line column)
                 ; x <- prog
                 ; eof <|> errorParse
                 ; return x
                 }) fileName input

errorParse = do
  { rest <- manyTill anyToken eof
  ; unexpected rest }

-- Top-level parser:
prog = fileContent >>= \n -> return $ Content n

------------------------------------------------------------------------------
-- Parser functions for our language
fileContent :: PS.Parser String
fileContent = do
  { content <- many anyChar
  ; return content
  }

------------------------------------------------------------------------------
-- Lexer
lexer :: PT.TokenParser ()
lexer = PT.makeTokenParser $ haskellStyle
  { reservedOpNames = []
  , reservedNames   = []
  }

charLiteral = PT.charLiteral  lexer
