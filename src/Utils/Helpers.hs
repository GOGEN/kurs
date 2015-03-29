module Helpers where

	import Types
	import Data.List

	partialSum	:: Int -> [Int] -> Int -> Float
	partialSum	q xs x = 
		let 	twoPi 	= 2 * pi
			xq 			= (convertInt x) / (convertInt q)
			cosArg 		= \b -> twoPi * xq * (convertInt b)
			deep 		= length xs
		in ( foldl' (\f s -> (+) f $ cos . cosArg $ s) 0 xs ) / convertInt deep

	getBSet :: Q -> D -> ChooseMethod -> [[Int]]
	getBSet q d choose = choose q d

	getMaxForAllX :: Int -> [Int] -> Float
	getMaxForAllX q xs 	= 
		let 	partSum 	= partialSum q xs
			ring		= [1..q `div` 2]
		in foldl' (\f s -> max f (partSum s)) 0 ring
		
	getLowerBound :: Q -> D
	getLowerBound  q = round . log . convertInt $ q

	convertInt :: Int -> Float
	convertInt x = fromInteger . toInteger $ x

	check :: Maybe Result -> String
	check result
	    | result == Nothing = "bSet not found"
	    | otherwise = show result