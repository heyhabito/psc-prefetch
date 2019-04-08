{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Data.Aeson
import Data.ByteString.Builder               (stringUtf8, toLazyByteString)
import Data.ByteString.Lazy.Char8            (unpack)
import Data.Functor                          ((<&>))
import Data.Map                              (Map)
import Data.Maybe                            (isJust)
import Data.Typeable
import GHC.TypeLits
import PscPrefetch.Data.Date
import PscPrefetch.Data.Dependency
import PscPrefetch.Data.Dependencies
import PscPrefetch.Data.FetchSubmodules
import PscPrefetch.Data.NixPrefetchGit
import PscPrefetch.Data.PackageName
import PscPrefetch.Data.PscPackage
import PscPrefetch.Data.PscPackageWithSha256
import PscPrefetch.Data.Repo
import PscPrefetch.Data.Rev
import PscPrefetch.Data.Sha256
import PscPrefetch.Data.Url
import PscPrefetch.Data.Version
import PscPrefetch.Prefetch
import Test.Hspec
import Test.QuickCheck                       (Arbitrary, Property, property)

main :: IO ()
main = hspec $ do
  describe "JSON" $ do
    jsonPropertyTest @Date
    jsonPropertyTest @Dependencies
    jsonPropertyTest @Dependency
    jsonPropertyTest @FetchSubmodules
    jsonPropertyTest @NixPrefetchGit
    jsonPropertyTest @PackageName
    jsonPropertyTest @PscPackage
    jsonPropertyTest @PscPackageWithSha256
    jsonPropertyTest @Repo
    jsonPropertyTest @Rev
    jsonPropertyTest @Sha256
    jsonPropertyTest @Url
    jsonPropertyTest @Version

jsonPropertyTest :: forall t. (Arbitrary t, Eq t, Show t, FromJSON t, ToJSON t, Typeable t) => SpecWith ()
jsonPropertyTest =
  it ("Roundtrip test for " <> (show $ typeOf @t undefined))$
  property $ \x -> (decode . encode @t $ x) == Just x
