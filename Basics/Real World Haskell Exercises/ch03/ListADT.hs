-- file: ch03/ListADT.hs

-- Recursive type definition (custom list)
data List a = Cons a (List a)
              | Nil
              deriving (Show)

-- Method to convert a Haskell list to custom list)
fromList :: [a] -> List a
fromList (x:xs) = Cons x (fromList xs)
fromList [] = Nil

-- Exercise:

-- Converse of fromList:
toList :: List a -> [a]
toList (Cons x xs) = x : toList xs
toList Nil = []
