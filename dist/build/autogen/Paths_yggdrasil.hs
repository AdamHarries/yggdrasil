module Paths_yggdrasil (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/adam/Development/yggdrasil/.cabal-sandbox/bin"
libdir     = "/Users/adam/Development/yggdrasil/.cabal-sandbox/lib/x86_64-osx-ghc-7.8.3/yggdrasil-0.1.0.0"
datadir    = "/Users/adam/Development/yggdrasil/.cabal-sandbox/share/x86_64-osx-ghc-7.8.3/yggdrasil-0.1.0.0"
libexecdir = "/Users/adam/Development/yggdrasil/.cabal-sandbox/libexec"
sysconfdir = "/Users/adam/Development/yggdrasil/.cabal-sandbox/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "yggdrasil_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "yggdrasil_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "yggdrasil_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "yggdrasil_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "yggdrasil_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)