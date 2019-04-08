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
import System.Console.ArgParser              (CmdLnInterface, ParserSpec, andBy, mkApp, parsedBy, reqPos, runApp, withParseResult)
import System.Environment                    (getArgs)

main :: IO ()
main = cli >>= (flip runApp print)

data PscPrefetchArguments
  = PscPrefetchArguments String String
  deriving (Show)

pscPrefetchArgumentsParser :: ParserSpec PscPrefetchArguments
pscPrefetchArgumentsParser = PscPrefetchArguments
  `parsedBy` reqPos "Input path"
  `andBy`    reqPos "Output path"

cli :: IO (CmdLnInterface PscPrefetchArguments)
cli = mkApp pscPrefetchArgumentsParser

prefetch :: PscPrefetchArguments -> IO ()
prefetch (PscPrefetchArguments inputPath outputPath) = do
  packageSetJson <- (toLazyByteString . stringUtf8) <$> readFile inputPath
  packageSet <- pure $ fromMaybe (fromList []) (decode @(Map PackageName PscPackage) packageSetJson)
  hashedPackageSet <- sequence $ hash <$> packageSet
  writeFile outputPath (unpack (encodePretty hashedPackageSet) <> "\n")
