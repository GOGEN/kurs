module Main where

	import Helpers
	import Generators
	import System.Random

	main = do
		gen <- newStdGen
		-- putStrLn . show $ [ getMaxForAllX bSet (2^10) (2^5) [1..(2^10)] | bSet <- chooseBrutforce (2^10) (2^5) ]
		putStrLn . check $ ( minimize ( 2 ^ 5 ) 0.01 chooseBrutforce )
		-- print (getBSet 4 2 chooseBrutforce)
		-- minimizeWithLog ( 2 ^ 5 ) 0.01 chooseBrutforce