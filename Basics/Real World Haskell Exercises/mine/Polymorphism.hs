-- file: mine/Polymorphism.hs

-- The type signature of this version of fst dictates the function's behaviour.
-- It can't do anything other than return the first parameter.
myFstGeneric :: (a, b) -> a
myFstGeneric (x, y) = x

-- This version is less restrictive.
-- It can perform any valid Num operations on a.
myFstNum :: Num a => (a, b) -> a
myFstNum (x, y) = x * 5

-- This type constructor (PamphletInfo) is polymorphic.
-- The result is that the Pamphlet value constructor can be called with a value
-- of any type as its last parameter.
data PamphletInfo a = Pamphlet Int String [String] a
                      deriving (Show)

-- Construct a pamphlet with the constraint that 'a' must be in the Num class.
-- Note: Printing myPamphlet would cause Haskell to choose the Integer type for
-- the value '12' because printing causes expression evaluation.
myPamphlet :: Num a => PamphletInfo a
myPamphlet = Pamphlet 348978932 "MegaPamphlet"
             ["James Shoes"] 12

-- Type aliases (synonyms) behave exactly as the types they refer to:
type AmazingType = Int

doubleInt :: AmazingType -> Int
doubleInt n = n * 2

result = doubleInt 5

-- Type aliases can be polymorphic if the type they refer to is polymorphic.
data Guy a = Guy Int a deriving (Show)
type GuyA = Guy
type GuyString = GuyA String

guy :: GuyString
guy = Guy 5 "AnyTypeCanGoHere"
