-- | Dependencies

import Control.Monad (forever)
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString (send, recv, sendAll)
import qualified Data.ByteString.Char8 as B8

-- | Create a TCP connection to hostname on specified port

connectToHost:: String -> Int -> IO Socket
connectToHost host port = withSocketsDo $ do
    addrInfo <- getAddrInfo Nothing (Just host) (Just $ show port)
    let serverAddr = head addrInfo
    sock <- socket (addrFamily serverAddr) Stream defaultProtocol
    connect sock (addrAddress serverAddr)
    return sock

-- | Lockstep behaviour

msgSender :: Socket -> IO ()
msgSender sock = do
    msg <- B8.getLine
    send sock msg
    if msg == B8.pack "q"
        then putStrLn "Disconnected!"
        else do
            rMsg <- recv sock 10
            B8.putStrLn rMsg
            msgSender sock

-- | Run a test client

tester :: IO ()
tester = do

    -- Create a socket
    sock <- connectToHost "localhost" 4444

    -- Pipe all input from getLine to the socket
    forever $ do
        B8.getLine >>= send sock

    sClose sock
    return ()
