-- file: ch03/Lending.hs

-- let:
lend amount balance = let reserve = 100
                          newBalance = balance - amount
                      in if balance < amount
                         then Nothing
                         else Just newBalance

-- where:
lend2 amount balance = if amount < reserve * 0.5
                       then Just newBalance
                       else Nothing
                       where reserve = 100
                             newBalance = balance - amount

lend3 amount balance
  | amount <= 0             = Nothing
  | amount > reserve * 0.5  = Nothing
  | otherwise               = Just newBalance
  where reserve = 100
        newBalance = balance - amount
