{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Version where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype Version = Version { runVersion :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
