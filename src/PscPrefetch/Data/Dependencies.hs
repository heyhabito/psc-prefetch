{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Dependencies where

import Data.Aeson
import GHC.Generics
import PscPrefetch.Data.Dependency
import Test.QuickCheck.Arbitrary

newtype Dependencies = Dependencies { runDependencies :: [Dependency] }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
