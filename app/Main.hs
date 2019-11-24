{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module Main where

----------------- original -----------------
-- import Cat.Quote
-- main = [cat| hello

--     this is my file
-- |]

------------ dec instead of exp ------------
-- import Cat.QuoteDec
-- [cat| hello

--     this is my file, version 2
-- |]


--------------- external dsl ---------------
-- import Cat.QuoteExternal
-- [cat| |]

--- external dsl with dec instead of exp ---
import Cat.QuoteExternalDec
[cat| |]
