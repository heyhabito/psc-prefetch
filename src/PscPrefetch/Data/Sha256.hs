{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.Sha256 where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype Sha256 = Sha256 { runSha256 :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, ToJSON)
  deriving newtype Show
