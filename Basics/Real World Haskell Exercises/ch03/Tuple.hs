-- file: ch03/Tuple.hs
third :: (a, b, c) -> c
third (a, b, c) = c

complicated :: (Eq c, Num c) => (Bool, a, [b], c) -> (a, [b])
complicated (True, a, x:xs, 5) = (a, xs)
