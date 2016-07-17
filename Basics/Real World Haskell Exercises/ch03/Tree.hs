-- file: ch03/Tree.hs
data Tree a = Node a (Tree a) (Tree a)
              | Empty
              deriving (Show)

simpleTree = Node "parent"
             (Node "leftChild" Empty Empty)
             (Node "rightChild" Empty Empty)

-- Exercise:

-- Tree type with a single constructor that uses Maybe instead of Empty

data MaybeTree a = MaybeNode a
                  (Maybe (MaybeTree a)) (Maybe (MaybeTree a))
                  deriving (Show)
