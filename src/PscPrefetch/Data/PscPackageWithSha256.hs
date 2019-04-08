{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.PscPackageWithSha256 where

import           Data.Aeson
import           GHC.Generics
import           PscPrefetch.Data.Dependencies
import           PscPrefetch.Data.Dependency
import qualified PscPrefetch.Data.PscPackage   as PscPackage
import           PscPrefetch.Data.Repo
import           PscPrefetch.Data.Sha256
import           PscPrefetch.Data.Url
import           PscPrefetch.Data.Version
import Test.QuickCheck.Arbitrary

data PscPackageWithSha256 = PscPackageWithSha256
    { dependencies    :: Dependencies
    , repo            :: Repo
    , version         :: Version
    , sha256          :: Sha256
    }
  deriving (Eq, Generic, FromJSON, ToJSON, Show)

instance Arbitrary PscPackageWithSha256 where
  arbitrary = PscPackageWithSha256 <$> dependencies' <*> repo' <*> version' <*> sha256'
    where
      dependencies' = arbitrary
      repo'         = arbitrary
      version'      = arbitrary
      sha256'       = arbitrary

fromPscPackage :: PscPackage.PscPackage -> Sha256 -> PscPackageWithSha256
fromPscPackage package hash =
  PscPackageWithSha256
    (PscPackage.dependencies package)
    (PscPackage.repo         package)
    (PscPackage.version      package)
    hash
