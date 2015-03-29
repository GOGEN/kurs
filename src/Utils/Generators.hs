module Generators where

	import Types
	import System.Random

	chooseBrutforce	:: Q -> Deep -> [[Int]]
	chooseBrutforce q deep 			= (brutforse [0..(q-1)] deep) ++ chooseBrutforce q (deep + 1)
	
	brutforse :: Ring -> Deep -> [[Int]]
	brutforse _ 0  = [[]]
	brutforse xs n = [ xs !! i : x | i <- [0..(length xs)-1] 
	                                  , x <- brutforse (drop (i+1) xs) (n-1) ]

	chooseRandom 					:: StdGen -> Q -> Deep-> [[Int]]
	chooseRandom gen q d 	= 
		let 	size = d
			(bSet, genn) = size `seq` randomBSets size q d gen
		in bSet ++ chooseRandom genn q (d+1)

	randomBSets 					:: Int -> Q -> Deep -> Rand [[Int]]
	randomBSets 0 _ _ gen 	 		= ([], gen)
	randomBSets size q d gen 		= 
		let 	(x, genn) = randomInts q d gen
			(xs, gennn) = size `seq` randomBSets (size - 1) q d genn
	        in (x:xs, gennn)

	randomInts 		   				:: Q -> Deep -> Rand [Int]
	randomInts _ 0 gen 				= ([], gen)
	randomInts q d gen 				= let 	(x, genn) = randomR (0, (q-1)) $ gen
	                         			  	(xs, gennn) = randomInts q (d-1) genn
	                     			in (x:xs, gennn)

	comb :: Int -> Int -> Int
	comb n m | (n < 0) || (m < 0) || (n < m) = 0
		| n < 2 * m = comb' n (n-m)
		| otherwise = comb' n m

	comb' :: Int -> Int -> Int
	comb' _ 0 = 1
	comb' n m = (comb' (n-1) (m-1)) * n `div` m