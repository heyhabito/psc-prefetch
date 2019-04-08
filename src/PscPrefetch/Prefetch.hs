{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
module PscPrefetch.Prefetch where

import           Data.Aeson
import           Data.Either.Combinators               (maybeToRight)
import           Data.Maybe                            (fromMaybe)
import           Data.ByteString.Builder               (stringUtf8, toLazyByteString)
import           Data.ByteString.Lazy                  (readFile)
import           GHC.Generics
import           Prelude                               hiding (readFile)
import           PscPrefetch.Data.PackageName
import qualified PscPrefetch.Data.NixPrefetchGit       as NixPrefetchGit
import qualified PscPrefetch.Data.PscPackage           as PscPackage
import qualified PscPrefetch.Data.PscPackageWithSha256 as PscPackageWithSha256
import           System.Environment                    (getArgs)
import           System.Process                        (readProcess)

hash :: PscPackage.PscPackage -> IO (Maybe PscPackageWithSha256.PscPackageWithSha256)
hash package@(PscPackage.PscPackage _ repo version) = do
  prefetch <- readProcess "nix-prefetch-git"
    [ "--fetch-submodules"
    , "--depth", "1"
    , "--quiet"
    , "--url", show repo
    , "--rev", show version
    ]
    ""
  decoded <- pure $ (decode @NixPrefetchGit.NixPrefetchGit (toLazyByteString $ stringUtf8 prefetch))
  sha256 <- pure $ NixPrefetchGit.sha256 <$> decoded
  pure $ PscPackageWithSha256.fromPscPackage package <$> sha256
