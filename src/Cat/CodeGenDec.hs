{-# LANGUAGE TemplateHaskell, QuasiQuotes, DeriveLift #-}
module Cat.CodeGenDec where

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
catCodeGen :: Cat -> Q [Dec]
catCodeGen prog = do
  let Content c = prog
  [d| main = do printContent c |]
