-- file: ch03/MySecond.hs

-- Here for example, but not a great approach to errors:
mySecond :: [a] -> a
mySecond xs = if null (tail xs)
                then error "list too short"
                else head (tail xs)

-- This is a safer approach:
safeSecond :: [a] -> Maybe a
safeSecond [] = Nothing
safeSecond xs = if null (tail xs)
                  then Nothing
                  else Just (head (tail xs))

tidySecond :: [a] -> Maybe a
tidySecond (_:x:_) = Just x
tidySecond _ = Nothing
