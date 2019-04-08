{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module PscPrefetch.Data.NixPrefetchGit where

import Data.Aeson
import GHC.Generics
import PscPrefetch.Data.Date
import PscPrefetch.Data.FetchSubmodules
import PscPrefetch.Data.Rev
import PscPrefetch.Data.Sha256
import PscPrefetch.Data.Url
import Test.QuickCheck.Arbitrary

data NixPrefetchGit = NixPrefetchGit
    { url             :: Url
    , rev             :: Rev
    , date            :: Date
    , sha256          :: Sha256
    , fetchSubmodules :: FetchSubmodules
    }
  deriving (Eq, Generic, FromJSON, ToJSON, Show)

instance Arbitrary NixPrefetchGit where
  arbitrary = NixPrefetchGit <$> sha256' <*> rev' <*> date' <*> url' <*> fetchSubmodules'
    where
    rev' = arbitrary
    url' = arbitrary
    date' = arbitrary
    sha256' = arbitrary
    fetchSubmodules' = arbitrary
