module Main where
import Text.EditDistance
import Text.CSL.Input.Identifier.Internal as Internal
import Text.CSL.Input.Identifier
import Text.CSL.Reference
import qualified Data.Map.Strict as Map
import Control.Monad.Trans.Either 
import Control.Monad.State as State

main :: IO ()
main = mainLoop []	

mainLoop :: [Reference] -> IO ()
mainLoop database = do 
	putStrLn "Please enter a reference"
	ref <- getLine
	if (ref == "q") || (ref == ":q") || (ref == "quit")
		then putStrLn "Quit requested, exiting."
		else if ref == "clear" then do
			putStrLn "Clearing database"
			mainLoop []
		else do 
			lookupResult <- resolveEitherRef ref
			newDb <- updateDatabase database lookupResult
			mainLoop newDb

updateDatabase :: [Reference] -> Either String Reference -> IO [Reference]
updateDatabase database lookupResult = case lookupResult of 
				Left err -> do 
					putStrLn ("Error looking up reference: " ++ err)
					return database
				Right ref -> do
					putStrLn "Adding to database"
					putStrLn "Database contains:"
					putStrLn $ show $ map (title) (ref:database)
			 		return (ref:database)

resolveEitherRef s = do
    fn <- getDataFileName "default.db"
    let go = withDatabaseFile fn $ ((runEitherT.resolveEither) s)
    State.evalStateT go (Database Map.empty)

-- getSimilar word database threshold = filter (\w -> (approxStringMatch word w) >= threshold) database

-- approxStringMatch sa sb = (bigger-ld)/bigger where
-- 	ld = fromIntegral $ levenshteinDistance defaultEditCosts sa sb 
-- 	bigger = fromIntegral $ max (length sa) (length sb)

-- approxStringMatch' sa sb = ( ((sal-ld)/sal),  ((sbl-ld)/sbl), ld) where
-- 	sal = fromIntegral $ length sa
-- 	sbl = fromIntegral $ length sb
-- 	ld = fromIntegral $ levenshteinDistance defaultEditCosts sa sb 


--type DbEntry = Reference
--type Database = [Reference] 
--	deriving (Show, Eq)
-- type Database = [(String, Int)]