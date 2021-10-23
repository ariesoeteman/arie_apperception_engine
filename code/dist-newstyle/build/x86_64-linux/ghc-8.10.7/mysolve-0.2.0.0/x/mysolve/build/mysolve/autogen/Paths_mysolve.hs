{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_mysolve (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,2,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/arie/.cabal/bin"
libdir     = "/home/arie/.cabal/lib/x86_64-linux-ghc-8.10.7/mysolve-0.2.0.0-inplace-mysolve"
dynlibdir  = "/home/arie/.cabal/lib/x86_64-linux-ghc-8.10.7"
datadir    = "/home/arie/.cabal/share/x86_64-linux-ghc-8.10.7/mysolve-0.2.0.0"
libexecdir = "/home/arie/.cabal/libexec/x86_64-linux-ghc-8.10.7/mysolve-0.2.0.0"
sysconfdir = "/home/arie/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "mysolve_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "mysolve_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "mysolve_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "mysolve_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "mysolve_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "mysolve_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
