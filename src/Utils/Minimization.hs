module Minimization where

	import Types 
	import Helpers
	import qualified Data.Maybe as M
	import qualified Data.List as L
	import GeneticMinimization
	import System.Random

	minimize :: Q -> Float -> ChooseMethod -> Maybe Result
	minimize q delta choose =
		let 	lowerD 			= getLowerBound q
			bSets 			= getBSet q lowerD choose
			getMax 			= getMaxForAllX q
			result 			= L.find ( \set -> delta > getMax set ) bSets
		in if result == Nothing then Nothing else Just (getMax (M.fromJust result), M.fromJust result, lowerD)

	minimizeGen :: RandomGen g => g-> Q -> Float -> Maybe Result
	minimizeGen gen q delta =
		let 	lowerD 			= getLowerBound q
			getMax 			= \(BSet (xs, _)) -> getMaxForAllX q xs
			stopf' 			= stopf delta
			result 			= L.find ( \(BSet (xs, _)) -> delta > err (BSet (xs, q)) ) (fst (chooseGen gen stopf' q lowerD ))
			getB 			= \(BSet (xs, _)) -> xs
		in if result == Nothing then Nothing else Just (getMax (M.fromJust result ), getB (M.fromJust result), lowerD)
