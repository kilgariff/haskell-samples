{--

1) Possible valid behaviours for:
last :: [a] -> a

- It could return the first, last or any element in the list (by means of
recursion).

2) Define a function lastButOne that returns the element before the last from a
given list [1].

3) What happens when it's called with a list that's too short?

It crashes with a runtime exception (list empty) that isn't very descriptive.

--}

-- [1] lastButOne implementation
lastButOne :: [a] -> a
lastButOne xs = if length xs == 2
                  then head xs
                  else lastButOne (tail xs)
