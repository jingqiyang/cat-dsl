{-# LANGUAGE TemplateHaskell, DeriveLift #-}
module Cat.Syntax where

import Language.Haskell.TH
import Language.Haskell.TH.Lift

data Cat = Content String
  deriving (Lift)
