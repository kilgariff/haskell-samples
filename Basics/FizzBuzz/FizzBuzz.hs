main :: IO ()
main = do
  sequence_ $ map (putStrLn . fizzBuzz) [1..100]

fizzBuzz :: Int -> String
fizzBuzz a
  | fizz a && buzz a = "FizzBuzz!"
  | fizz a = "Fizz"
  | buzz a = "Buzz"
  | otherwise = show a
  where
    fizz a = (a `mod` 3 == 0)
    buzz a = (a `mod` 5 == 0)
