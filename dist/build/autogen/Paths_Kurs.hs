module Paths_Kurs (
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
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/gogen/.cabal/bin"
libdir     = "/home/gogen/.cabal/lib/x86_64-linux-ghc-7.6.3/Kurs-0.1.0.0"
datadir    = "/home/gogen/.cabal/share/x86_64-linux-ghc-7.6.3/Kurs-0.1.0.0"
libexecdir = "/home/gogen/.cabal/libexec"
sysconfdir = "/home/gogen/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Kurs_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Kurs_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Kurs_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Kurs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Kurs_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
