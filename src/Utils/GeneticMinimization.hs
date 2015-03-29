module GeneticMinimization where

	import GeneticAlgorithm
	import Helpers
	import Control.DeepSeq
	import System.Random
	import qualified Data.List as L

	newtype BSet = BSet ([Int], Int) deriving (Show, Eq)

	instance NFData BSet where
		rnf (BSet (xs, _)) = rnf xs `seq` ()

	err	:: BSet -> Float
	err	(BSet (xs, q)) = getMaxForAllX q xs

	instance Individual BSet where
		crossover g (BSet (xs1, q)) (BSet (xs2, _)) =
			let 	(idx, g') = randomR (0, length xs1 -1) g
				xs1' = take idx xs1
				xs2' = drop idx xs2
				xs   = xs1' ++ xs2'
			in ([BSet (xs, q)], g')

		mutation g (BSet (xs, q)) =
			let 	(idx, g') = randomR (0, length xs - 1) g
				(dx, g'') = randomR (0, q - 1) g'
				xs' = take idx xs ++ [dx] ++ drop (idx+1) xs
			in (BSet (xs', q), g'')

		fitness set 	= 
			let max_err = 1.0 in
			max_err - (min max_err (err set))

	stopf :: Float -> BSet -> Int -> Bool
	stopf delta set gnum = gnum > 20 || delta > err set

	randomIndividual :: RandomGen g => Int -> Int -> g -> (BSet, g)
	randomIndividual q 0 gen = (BSet ([], q), gen)
	randomIndividual q d gen = 
		let (lst, gen') =
			L.foldl'
				(\(xs, g) _ -> let (x, g') = randomR (0, (q-1)) g in (x:xs,g') )
				([], gen) [1..d]
		in (BSet (lst, q), gen')

	chooseGen :: RandomGen g => g -> (BSet -> Int -> Bool) -> Int -> Int -> ([BSet], g)
	chooseGen gen stopf' q d =
		let 	(xs, gen') 	= runGA gen d 1.0 (randomIndividual q d) stopf'
			(xss, gen'')= chooseGen gen' stopf' q (d+1)
		in (xs:xss, gen'')