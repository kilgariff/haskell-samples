-- file: BogusPattern.hs

data Fruit = Apple | Orange
             deriving (Show)

apple = "apple"

orange = "orange"

-- The following functions are examples of how external
-- variables can't be used in pattern matching, ie. when
-- using 'case' or function equations:

whichFruit :: String -> Fruit
whichFruit f =
  case f of
    apple -> Apple
    orange -> Orange

equational apple = Apple
equational orange = Orange

-- This is because the names 'apple' and 'orange' are local
-- pattern variables that will each match any value, causing
-- an 'overlappied pattern' warning from GHC). They don't
-- refer to the global String variables 'apple' and 'orange'.

-- Here's a corrected version:

betterFruit :: String -> Fruit
betterFruit f =
  case f of
    "apple" -> Apple
    "orange" -> Orange
