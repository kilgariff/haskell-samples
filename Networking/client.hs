-- | Dependencies

import           Control.Concurrent
import           Control.Concurrent.Async
import           Control.Exception
import qualified Data.ByteString.Char8     as B8
import           Data.Function             (fix)
import           Network.Socket            hiding (recv, recvFrom, send, sendTo)
import           Network.Socket.ByteString (recv, send, sendAll)
import           System.IO
import           System.IO.Error

-- | Create a TCP connection to hostname on specified port

connectToHost:: String -> Int -> IO Socket
connectToHost host port = do

    addrInfo <- getAddrInfo Nothing (Just host) (Just $ show port)
    let serverAddr = head addrInfo
    sock <- socket (addrFamily serverAddr) Stream defaultProtocol
    connect sock (addrAddress serverAddr)
    return sock

-- | Create a stdin -> TCP pipe

pipeInput :: Socket -> IO ()
pipeInput sock = do
    result <- tryIOError (B8.getLine >>= sendAll sock)
    case result of
        Left _ -> do
            putStrLn "Got IO Exception while sending"

        Right _ -> pipeInput sock

-- | Create a TCP -> stdout pipe

pipeOutput :: Socket -> IO ()
pipeOutput sock = do
    result <- tryIOError (recv sock 4096)
    case result of
        Left _ -> do
            putStrLn "Got IO Exception while receiving"
        Right rMsg -> do
            if B8.length rMsg == 0
                then do
                    putStrLn "Connection closed by remote host"
                else do
                    B8.putStrLn rMsg
                    pipeOutput sock


-- | Proxy all IO to/from a remote TCP connection

fullDuplexProxy :: IO ()
fullDuplexProxy = withSocketsDo $ do

    -- Create a socket
    sock <- connectToHost "127.0.0.1" 4444

    -- Set up bi-directional (full duplex) pipe
    race_ (pipeInput sock) (pipeOutput sock)

    -- Clean up
    putStrLn "Cleaning up"
    sClose sock
    return ()
