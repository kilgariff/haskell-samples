-- Can't get this to work:

class N a where
    f :: a -> a

instance N Integer where
    f x = x + 1

newtype NString = NStr [Char]
instance N NString where
    f x = x

{--
 Simple example of nullary type constructor
 and nullary data constructor definitions,
 plus scoping rules for data constructors.
--}

{--
data MyBool = True | False 

class Intable a where
    toInt :: a -> Integer

instance Intable MyBool where
    toInt Main.True = 1
    toInt Main.False = 0

instance Intable Bool where
    toInt Prelude.True = 3
    toInt Prelude.False = 2

test = toInt Prelude.True
--}

{-- Unary type constructors, --}

-- 'Point' here is a type constructor when used on the left,
-- and a data constructor when used on the right.

data Point a = Point a a deriving Show
p0 = Point 3.5 3.6

-- 'Tree' here is a type constructor when used on the left,
-- and a recursive application of that type constructor when
-- used on the right.

data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving Show
l0 = Leaf 1
l1 = Leaf 2
b0 = Branch l0 l1

{-- Use of the 'Maybe' type constructor --}

theThing :: Int -> Maybe Integer
theThing 1 = Just 1
theThing 2 = Nothing

isNothing :: Eq a => Maybe a -> Bool
isNothing x 
    | x == Nothing = True
    | otherwise = False

isOneNothing = isNothing $ theThing 1
isTwoNothing = isNothing $ theThing 2
