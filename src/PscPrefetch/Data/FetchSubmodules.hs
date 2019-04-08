{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.FetchSubmodules where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype FetchSubmodules = FetchSubmodules { runFetchSubmodules :: Bool }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
