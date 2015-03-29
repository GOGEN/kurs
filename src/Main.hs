module Main where

	import Helpers
	import System.Random
	import Minimization
	import GeneticAlgorithm
	import GeneticMinimization

	main :: IO ()
	main =
		let 	res = \gen -> runGA gen 50 1.0 (randomIndividual (2^10) 50) (stopf 0.01)
			getMax = \(BSet (xs, q)) -> getMaxForAllX q xs
		in do
			gen <- newStdGen
			print (getMax (fst (res gen)))
		-- putStrLn . show $ [ getMaxForAllX bSet (2^10) (2^5) [1..(2^10)] | bSet <- chooseBrutforce (2^10) (2^5) ]
		-- putStrLn . check $ ( minimize ( 2 ^ 10 ) 0.01 (chooseRandom gen) )
		-- print (getBSet (2^10) 7 (chooseRandom gen) )
		-- minimizeWithLog ( 2 ^ 10) 0.01 (chooseRandom gen)
		-- putStrLn . check $ ( minimizeGen gen ( 2 ^ 10 ) 0.01)
		-- print (runGA gen 7 1.0 (randomIndividual (2^15) 7) (stopf 0.01))
		-- print (randomIndividual 4 2 gen )