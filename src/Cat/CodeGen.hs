{-# LANGUAGE TemplateHaskell, QuasiQuotes, DeriveLift #-}
module Cat.CodeGen where

import Language.Haskell.TH
import Language.Haskell.TH.Lift
import System.IO
import System.Exit

import Instances.TH.Lift

import Cat.Syntax

-- runtime system
printContent :: String -> IO ()
printContent c = putStr c

-- metaprogram
catCodeGen :: Cat -> Q Exp
catCodeGen prog = do
  let Content c = prog
  [| do printContent c |]
