{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_morse (
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
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/kevin/haskell_learning/14_testing/morse/.stack-work/install/x86_64-linux/lts-12.19/8.4.4/bin"
libdir     = "/home/kevin/haskell_learning/14_testing/morse/.stack-work/install/x86_64-linux/lts-12.19/8.4.4/lib/x86_64-linux-ghc-8.4.4/morse-0.1.0.0-4u16HIsPnFzJFl1Cyn47g9"
dynlibdir  = "/home/kevin/haskell_learning/14_testing/morse/.stack-work/install/x86_64-linux/lts-12.19/8.4.4/lib/x86_64-linux-ghc-8.4.4"
datadir    = "/home/kevin/haskell_learning/14_testing/morse/.stack-work/install/x86_64-linux/lts-12.19/8.4.4/share/x86_64-linux-ghc-8.4.4/morse-0.1.0.0"
libexecdir = "/home/kevin/haskell_learning/14_testing/morse/.stack-work/install/x86_64-linux/lts-12.19/8.4.4/libexec/x86_64-linux-ghc-8.4.4/morse-0.1.0.0"
sysconfdir = "/home/kevin/haskell_learning/14_testing/morse/.stack-work/install/x86_64-linux/lts-12.19/8.4.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "morse_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "morse_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "morse_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "morse_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "morse_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "morse_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
