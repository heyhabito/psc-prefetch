{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Dependency where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype Dependency = Dependency { runDependency :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving Show
