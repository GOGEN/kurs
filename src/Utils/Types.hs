module Types where

	import System.Random

	type X 				= Int
	type SIGMA			= Float
	type ChooseMethod 	= (Ring -> D -> [BSet])
	type Ring 			= [Int]
	type Deep 			= Int
	type BSet 			= [Int]
	type Q 				= Int
	type D 				= Int
	type Rand a 		= StdGen -> (a, StdGen)
	type Result			= (Float, D)