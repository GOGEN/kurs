module Generators where

	import Types
	import System.Random

	chooseBrutforce 				:: Ring -> D -> [BSet]
	chooseBrutforce ring d 			= brutforse ring $ d
	
	brutforse :: Ring -> Deep -> [BSet]
	brutforse _ 0  = [[]]
	brutforse xs n = [ xs !! i : x | i <- [0..(length xs)-1] 
	                                  , x <- brutforse (drop (i+1) xs) (n-1) ]

	chooseRandom 					:: StdGen -> Q -> D -> [BSet]
	chooseRandom gen q d 			= fst $ randomBSets  d q d gen

	randomBSets 					:: Int -> Q -> D -> Rand [BSet]
	randomBSets 0 _ _ gen 	 		= ([], gen)
	randomBSets size q d gen 		= let 	(x, genn) = randomInts q d gen
	                               			(xs, gennn) = randomBSets (size - 1) q d genn
	                     			in (x:xs, gennn)

	randomInts 		   				:: Q -> D -> Rand [Int]
	randomInts _ 0 gen 				= ([], gen)
	randomInts q d gen 				= let 	(x, genn) = randomR (0, (q-1)) $ gen
	                         			  	(xs, gennn) = randomInts q (d-1) genn
	                     			in (x:xs, gennn)

	-- permulation :: Ring -> [BSet]
	-- permulation [] = [[]]
	-- permulation ring =
	-- 	[ (x:xs) | x <- ring, xs <- permulation $ delete x ring ]
