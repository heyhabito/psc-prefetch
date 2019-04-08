{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Rev where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype Rev = Rev { runRev :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
