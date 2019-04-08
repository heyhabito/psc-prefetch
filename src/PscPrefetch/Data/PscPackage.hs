{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.PscPackage where

import Data.Aeson
import GHC.Generics
import PscPrefetch.Data.Dependencies
import PscPrefetch.Data.Repo
import PscPrefetch.Data.Url
import PscPrefetch.Data.Version
import Test.QuickCheck.Arbitrary

data PscPackage = PscPackage
    { dependencies    :: Dependencies
    , repo            :: Repo
    , version         :: Version
    }
  deriving (Eq, Generic, FromJSON, ToJSON, Show)

instance Arbitrary PscPackage where
  arbitrary = PscPackage <$> dependencies' <*> repo' <*> version'
    where
      dependencies' = arbitrary
      repo'         = arbitrary
      version'      = arbitrary
