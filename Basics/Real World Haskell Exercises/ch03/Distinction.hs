-- file: ch03/Distinction.hs

-- These values have the same type (which is a 2-tuple of Strings), meaning
-- they can be used interchangeably in functions despite having different
-- use cases.
a = ("Porpoise", "Grey")
b = ("Table", "Oak")

-- These values make use of algebraic data types, so are distinct types despite
-- being otherwise structurally equivalent.
data Cetacean = Cetacean String String
                deriving (Show)

data Furniture = Furniture String String
                 deriving (Show)

c = Cetacean "Porpoise" "Grey"
d = Furniture "Table" "Oak"
