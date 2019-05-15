import Network.Socket

openSocket :: FilePath -> IO Socket
openSocket p = do
  sock <- socket AF_UNIX
                 Stream
                 defaultProtocol
  connect sock sockAddr
  return sock
  where sockAddr = SockAddrUnix . encodeString $ p --broken!