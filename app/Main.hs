{-# LANGUAGE TypeApplications #-}
module Main where

import Data.Aeson                            (decode)
import Data.Aeson.Encode.Pretty              (encodePretty)
import Data.ByteString.Builder               (toLazyByteString, stringUtf8)
import Data.ByteString.Lazy.Char8            (unpack)
import Data.Coerce                           (coerce)
import Data.Map                              (Map, fromList, toList)
import Data.Maybe                            (fromMaybe)
import PscPrefetch.Prefetch                  (hash)
import PscPrefetch.Data.PackageName
import PscPrefetch.Data.PscPackage           (PscPackage (..))
import PscPrefetch.Data.PscPackageWithSha256
import System.Environment                    (getArgs)

main :: IO ()
main = do
  args <- getArgs
  prefetch (head args) (head $ tail args)

prefetch :: String -> String -> IO ()
prefetch inputPath outputPath = do
  packageSetJson <- (toLazyByteString . stringUtf8) <$> readFile inputPath
  packageSet <- pure $ fromMaybe (fromList []) (decode @(Map PackageName PscPackage) packageSetJson)
  hashedPackageSet <- sequence $ hash <$> packageSet
  writeFile outputPath (unpack (encodePretty hashedPackageSet) <> "\n")
