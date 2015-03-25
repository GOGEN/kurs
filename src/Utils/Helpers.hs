module Helpers where

	import Types
	import Data.List
	import Data.Maybe

	getBSet 						:: Ring -> D -> ChooseMethod -> [BSet]
	getBSet ring d choose 			= choose ring d

	getMaxForAllX 					:: Q -> Ring -> (BSet, D) -> Float
	getMaxForAllX q  ring set  = 
		let deepRing = q `div` 2 
		in maximum [ partSum x | x <- take deepRing ring, x /= 0 ]
			where partSum = partialSum set q

	partialSum						:: (BSet, D) -> Q -> X -> Float
	partialSum	set q x 			= 
		let 	twoPi = 2 * pi
			xq = (convertInt x) / (convertInt q)
			cosArg = \b -> twoPi * xq * (convertInt b)
			deep = snd set
		in ( sum [ cos ( cosArg b ) | b <- fst set ] ) / convertInt deep

	minimize 						:: Q -> SIGMA -> ChooseMethod -> Maybe Result
	minimize q sigma choose =
		let 	deepRange = [getLowerBound q .. q ]
			ring = [0..(q-1)]
			bSets = concat [ map (\b-> (b, d) ) ( getBSet ring d choose ) | d <- deepRange ]
			getMax = getMaxForAllX q ring
			result = find ( \set -> sigma > getMax set ) bSets
		in if result == Nothing then Nothing else Just (getMax (fromJust result), snd . fromJust $ result)
		
	getLowerBound 					:: Q -> D
	getLowerBound  q 			= 
		round . log . convertInt $ q

	convertInt 						:: Int -> Float
	convertInt x 					= fromInteger .toInteger $ x

	check 							:: Maybe Result -> String
	check result
	    | result == Nothing = "bSet not found"
	    | otherwise = show result

	-- minimizeWithLog					:: Q -> SIGMA -> ChooseMethod -> IO ()
	-- minimizeWithLog	q sigma choose  = do
	-- 	let 	lowerBound = getLowerBound sigma q
	-- 		dList = [ lowerBound .. q ]
	-- 		bList = map (\d -> (d, getBSet q d choose) ) dList
	-- 		setList = map (\set -> (fst set, minimum [ getMaxForAllX q (bSet, fst set) | bSet <- snd set])) bList
	-- 		findRes = find (\set -> sigma > snd set ) $ setList
	-- 		in 	do
	-- 		print lowerBound
	-- 		print (takeWhile (\b -> b /= fromJust findRes) setList)
	-- 		print findRes