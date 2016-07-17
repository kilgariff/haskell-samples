-- file: ch03/AltCustomer.hs

type Address = [String]

data Customer = Customer Int String [String]
                deriving (Show)

customerID :: Customer -> Int
customerID (Customer id _ _) = id

customerName :: Customer -> String
customerName (Customer _ id _)  = id

customerAddress :: Customer -> Address
customerAddress (Customer _ _ address) = address
