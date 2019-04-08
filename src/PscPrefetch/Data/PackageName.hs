{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.PackageName where

import Data.Aeson
import GHC.Generics
import Test.QuickCheck.Arbitrary

newtype PackageName = PackageName { runPackageName :: String }
  deriving (Arbitrary, Eq, Generic, FromJSON, FromJSONKey, ToJSON, ToJSONKey)
  deriving newtype (Ord, Show)
