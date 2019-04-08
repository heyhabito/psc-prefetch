{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Url where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype Url = Url { runUrl :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
