-- file: ch02/Take.hs
myTake :: Int -> [a] -> [a]
myTake n xs = if n > 0 && not (null xs)
                then (head xs) : (myTake (n - 1) (tail xs))
                else []
