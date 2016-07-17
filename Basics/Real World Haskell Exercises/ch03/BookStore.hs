-- file: ch03/BookStore.hs

-- Type constructors:

data BookInfo = Book Int String [String]
                deriving Show

data MagazineInfo = Magazine Int String [String]
                    deriving (Show)

myInfo = Book 478934792 "Test"
         ["Ross Kilgariff", "Mairi Collins"]

-- Type aliases (synonyms):

type CustomerID = Int
type ReviewBody = String

data BookReview = BookReview BookInfo CustomerID ReviewBody
                  deriving (Show)

myReview = BookReview myInfo 2347982 "It was great!"

type BookRecord = (BookInfo, BookReview)

myRecord :: BookRecord
myRecord = (myInfo, myReview)

-- Algebraic data types:

type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
                 | CashOnDelivery
                 | Invoice CustomerID
                 deriving (Show)

-- Pattern matching

bookID (Book id title authors) = id
bookTitle (Book id title authors) = title
bookAuthors (Book id title authors) = authors

nicerID (Book id _ _) = id
nicerTitle (Book _ title _) = title
nicerAuthors (Book _ _ authors) = authors

-- Record Syntax

data Customer = Customer {
    customerID :: CustomerID
  , customerName :: String
  , customerAddress :: Address
  } deriving (Show)

toastKing = Customer {
    customerID = 43478293
  , customerAddress = ["The moon", "Space"]
  , customerName = "Toast King"
  }
