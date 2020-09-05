{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_fingerd (
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

bindir     = "/home/kevin/haskell_learning/31_final_project/fingerd/.stack-work/install/x86_64-linux-tinfo6/2e43211d0491d04a37b06bfa9647e70a35c2d77b538cff6be6544d57d47b803c/8.8.4/bin"
libdir     = "/home/kevin/haskell_learning/31_final_project/fingerd/.stack-work/install/x86_64-linux-tinfo6/2e43211d0491d04a37b06bfa9647e70a35c2d77b538cff6be6544d57d47b803c/8.8.4/lib/x86_64-linux-ghc-8.8.4/fingerd-0.1.0.0-J0yJ8SyxqBY4psPCP1pIvC-fingerd"
dynlibdir  = "/home/kevin/haskell_learning/31_final_project/fingerd/.stack-work/install/x86_64-linux-tinfo6/2e43211d0491d04a37b06bfa9647e70a35c2d77b538cff6be6544d57d47b803c/8.8.4/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/home/kevin/haskell_learning/31_final_project/fingerd/.stack-work/install/x86_64-linux-tinfo6/2e43211d0491d04a37b06bfa9647e70a35c2d77b538cff6be6544d57d47b803c/8.8.4/share/x86_64-linux-ghc-8.8.4/fingerd-0.1.0.0"
libexecdir = "/home/kevin/haskell_learning/31_final_project/fingerd/.stack-work/install/x86_64-linux-tinfo6/2e43211d0491d04a37b06bfa9647e70a35c2d77b538cff6be6544d57d47b803c/8.8.4/libexec/x86_64-linux-ghc-8.8.4/fingerd-0.1.0.0"
sysconfdir = "/home/kevin/haskell_learning/31_final_project/fingerd/.stack-work/install/x86_64-linux-tinfo6/2e43211d0491d04a37b06bfa9647e70a35c2d77b538cff6be6544d57d47b803c/8.8.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "fingerd_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "fingerd_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "fingerd_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "fingerd_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "fingerd_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "fingerd_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
