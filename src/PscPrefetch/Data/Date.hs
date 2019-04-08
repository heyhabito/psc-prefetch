{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Date where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype Date = Date { runDate :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
