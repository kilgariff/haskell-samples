
-- Records

data Player = Player {
	battlescore :: Int,
	wins :: Float,
	losses :: Float,
	winLossRatio :: Player -> Float
}

data Bucket = Bucket {
	name :: String,
	test :: Player -> Bool
}

-- Constructors

makePlayer :: Int -> Float -> Float -> Player
makePlayer bs w l =
	Player {
		battlescore = bs,
		wins = w,
		losses = l,
		winLossRatio = (\a -> (wins a))
	}

makeBucket :: String -> (Player -> Bool) -> Bucket
makeBucket n t =
	Bucket {
		name = n,
		test = t
	}

-- Sample Data

buckets :: [Bucket]
buckets = [(makeBucket "new_players" (\a -> (battlescore a) <= 50)),
		   (makeBucket "wl_below_0.6" (\a -> (winLossRatio a) < 0.6))]

examplePlayer :: Player
examplePlayer = Player { battlescore = 30, wins = 10 , losses = 7 }

-- Bucket Test

bucketTest b p = putStrLn (case (test b) p of
				   True -> "Test passed for " ++ (name b)
				   False -> "Test failed for " ++ (name b))

-- Main

main = do
	 map (\x -> (bucketTest x) examplePlayer) buckets
