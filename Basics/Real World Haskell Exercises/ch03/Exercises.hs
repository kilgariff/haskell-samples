-- file: ch03/Exercises.hs
import Data.List (sortBy)

-- 1) Write a fuction that computes the number of elements in a list.
--    To test it, ensure that it gives the same answers as the standard length
--    function.

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

-- :D

-- 2) Add a type signature for your function to your source file. To test it,
--    load the source file into ghci again.

-- :D

-- 3) Write a function that computes the mean of a list, i.e., the sum of all
--    the elements in the list divided by its length. (You may need to use the
--    fromIntegral function to convert the length of the list from an integer
--   into a floating-point number.)

mySum :: (Fractional a) => [a] -> a
mySum []     = 0
mySum [x] = x
mySum (x:xs) = x + mySum xs

mean :: (Fractional a) => [a] -> Maybe a
mean [] = Nothing
mean xs = Just (mySum xs / fromIntegral (myLength xs))

-- :D

-- 4) Turn a list into a palindrome, i.e., it should read the same both backward
--    and forward. For example, given the list [1, 2, 3], your function should
--    return [1, 2, 3, 3, 2, 1].

myReverse :: [a] -> [a]
myReverse (x:xs) = myReverse xs ++ [x]
myReverse xs = xs

palin :: [a] -> [a]
palin xs = xs ++ myReverse xs

-- :D

-- 5) Write a function that determines whether its input list is a palindrome.

isPalin :: Eq a => [a] -> Bool
isPalin [] = True
isPalin [x] = True
isPalin [x, y] = x == y
isPalin (x:xs) =
  isPalin [x, head sx] && isPalin (tail sx)
  where sx = myReverse xs

-- :D

-- 6) Create a function that sorts a list of lists based on the length of each
--    sublist. (You may want to look at the sortBy function from the Data.List
--    module.)

sortByLength :: [[a]] -> [[a]]
sortByLength =
  sortBy lengthOrd where
    lengthOrd x y
         | myLength x > myLength y = GT
         | otherwise               = LT

-- :D

-- 7) Define a function that joins a list of lists together using a separator value:

intersperse :: a -> [[a]] -> [a]
intersperse s []     = []
intersperse s [x]    = x
intersperse s (x:xs) = x ++ s : intersperse s xs

-- The separator should appear between elements of the list, but it should not
-- follow the last element. Your function should behave as follows:

{--

ghci> intersperse ',' []
""

ghci> intersperse ',' ["foo"]
"foo"

ghci> intersperse ',' ["foo", "bar", "baz", "quux"]
"foo,bar,baz,quux"

--}

-- :D

-- 8) Using the binary tree type that we defined earlier in this chapter, write
--    a function that will determine the height of the tree. The height is the
--    largest number of hops from the root to an Empty. For example, the tree
--    Empty has height zero; Node "x" Empty Empty has height one; Node "x" Empty
--    (Node "y" Empty Empty) has height two; and so on.

data Tree a = Node a (Tree a) (Tree a) | Empty
              deriving (Show)

treeHeight :: Tree a -> Int
treeHeight Empty = 0
treeHeight (Node _ left right)
  | treeHeight left > treeHeight right = 1 + treeHeight left
  | otherwise                          = 1 + treeHeight right

-- :D

-- 9) Consider three two-dimensional points, a, b, and c If we look at the angle
--    formed by the line segment from a to b and the line segment from b to c,
--    it turns left, turns right, or forms a straight line. Define a Direction
--    data type that lets you represent these possibilities.

data Direction = LeftTurn | RightTurn | Forward | Reverse
                 deriving (Eq, Show)

-- :D

-- 10) Write a function that calculates the turn made by three two-dimensional
--    points and returns a Direction.

data Point a =
  Point {
    px :: a,
    py :: a
  } deriving (Eq, Show)

data Vector a =
  Vector {
    vx :: a,
    vy :: a,
    angle :: a,
    magnitude :: a
  } deriving (Eq, Show)

pointsToVector :: RealFloat a => Point a -> Point a -> Vector a
pointsToVector (Point x1 y1) (Point x2 y2) =
  Vector x y (atan2 y x) (sqrt (x * x) + (y * y)) where
    x = x2 - x1
    y = y2 - y1

data Path a =
  Path {
    pathBegin :: Point a,
    pathMiddle :: Point a,
    pathEnd :: Point a
  } deriving (Eq, Show)

pathDirection :: RealFloat a => Path a -> (a, Direction)
pathDirection (Path b m e) =
  case () of _
              | theta == pi -> (theta, Reverse)
              | theta < 0 -> (theta, LeftTurn)
              | theta > 0 -> (theta, RightTurn)
              | theta == 0 -> (theta, Forward)
  where theta =
              wrap (a2 - a1) where
              a1   = angle (pointsToVector b m)
              a2   = angle (pointsToVector b e)
        wrap a
              | a > pi  = a - 2 * pi
              | a <= -pi = a + 2 * pi
              | otherwise = a

data Quadrant = TopLeft | TopRight | BottomLeft | BottomRight
                deriving (Show, Eq)

quadrant :: RealFloat a => Vector a -> Quadrant
quadrant (Vector x y _ _)
  | x >= 0 && y >= 0   = TopRight
  | x >= 0 && y < 0    = BottomRight
  | x < 0 && y >= 0    = TopLeft
  | x < 0 && y < 0     = BottomLeft

pathQuadrants :: RealFloat a => Path a -> (Quadrant, Quadrant)
pathQuadrants (Path b m e) =
  (quadrant (pointsToVector b m), quadrant (pointsToVector m e))

testPaths :: RealFloat a => [(Path a, Direction)]
testPaths = [
    (Path (Point 0 0) (Point 0.75 0.75) (Point 1.5 0), LeftTurn),
    (Path (Point 0 0) (Point 0.75 (-0.75)) (Point 1.5 0), RightTurn),
    (Path (Point 0 0) (Point (-0.75) 1) (Point 0 2), LeftTurn),
    (Path (Point 0 0) (Point 0.75 1) (Point 0 2), RightTurn),
    (Path (Point 0 0) (Point 0.75 (-1)) (Point 0 (-2)), LeftTurn),
    (Path (Point 0 0) (Point (-0.75) (-1)) (Point 0 (-2)), RightTurn),
    (Path (Point 0 0) (Point (-0.75) (-1)) (Point (-1) 0), LeftTurn),
    (Path (Point 0 0) (Point (-0.75) 1) (Point (-1) 0), RightTurn),
    (Path (Point 0 0) (Point 1 0) (Point 2 0), Forward),
    (Path (Point 1 0) (Point 0 0) (Point 2 0), Reverse),
    (Path (Point 1 0) (Point 0 0.1) (Point 2 0), LeftTurn),
    (Path (Point 1 0) (Point 0 (-0.1)) (Point 2 0), RightTurn),
    (Path (Point 0 0) (Point (-1) 0) (Point (-2) 0), Forward),
    (Path (Point (-1) 0) (Point 0 0) (Point (-2) 0), Reverse)
  ]

-- 11) Define a function that takes a list of two-dimensional points and
--     computes the direction of each successive triple. Given a list of
--     points [a, b, c, d, e], it should begin by computing the turn made
--     by [a, b, c], then the turn made by [b, c, d], then [c, d, e].
--     Your function should return a list of Direction.


-- 12) Using the code from the preceding three exercises, implement Graham's
--     scan algorithm for the convex hull of a set of 2D points. You can find
--    good descriptions of what a convex hull is, and how the Graham scan
--   algorithm should work on Wikipedia.
