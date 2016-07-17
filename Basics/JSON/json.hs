import Data.Aeson
import Data.Text
import qualified Data.ByteString.Lazy.Char8 as B8
import Control.Monad

data Person =
  Person { firstName  :: !Text
         , lastName   :: !Text
         , age        :: Int
         , likesPizza :: Bool
           } deriving Show

instance FromJSON Person where
  parseJSON (Object v) =
     Person <$> v .: (pack "firstName")
            <*> v .: (pack "lastName")
            <*> v .: (pack "age")
            <*> v .: (pack "likesPizza")

parseJSON _ = mzero

{--
instance ToJSON Person where
toJSON (Person firstName lastName age likesPizza) =
   object [ "firstName"  .= firstName
          , "lastName"   .= lastName
          , "age"        .= age
          , "likesPizza" .= likesPizza
            ]

instance FromJSON Person where
parseJSON (Object v) =
    Person <$> v .:? "firstName"
         <*> v .:  "lastName"
         <*> v .:  "age"
         <*> v .:  "likesPizza"
--}

ross = Person (pack "Ross") (pack "Kilgariff") 24 True

result :: Maybe Person
result = decode (B8.pack "{\"firstName\": \"Ross\", \"lastName\": \"Kilgariff\", \"age\": 24, \"likesPizza\": true}")

main = do
  putStrLn $ "Person was " ++ show result
