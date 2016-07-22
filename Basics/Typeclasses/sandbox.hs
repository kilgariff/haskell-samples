
sayHello :: String -> IO ()
sayHello name = putStrLn ("Hello, " ++ name ++ "!")

sayHelloWorld :: IO ()
sayHelloWorld = putStrLn ("Hello, World!")

-- I'd like to break apart the type signatures involved here...
-- So, (>>) :: Monad m => m a -> m b -> m b
-- and (>>=) :: Monad m => m a -> (a -> m b) -> m b

-- Consider this expression:
echoInput = getLine >>= putStrLn 

-- (>>=)'s polymorphic type variable m, constrained to the Monad type class,
-- describes 
-- is obeyed by the first argument (the function getLine) which is of type
-- IO String.

----------------
sayHelloToUser = putStr "Please enter your name: " >> getLine >>= \a -> sayHello a

sayHelloToUser' = putStr "Please enter your name: " >> getLine >>= \a -> 
                    putStr "and your favourite animal: " >> getLine >>= \b ->
                        sayHello a >> sayHello b

data Foo = TheFoo | TheOtherFoo deriving Show

class Fooable a where
    doTheFoo :: a -> Foo 

instance Fooable Integer where
    doTheFoo x
        | x > 5 = TheFoo
        | otherwise = TheOtherFoo

instance Fooable Foo where
    doTheFoo x = x

class Turnippable t where
    itsTurnipTime :: t a -> a

-- Nope:
--data Turnip a = Turnip { x :: a } deriving Show
--instance Turnippable Turnip where
--    itsTurnipTime x = x.x
