module TH where

-- used for importing textual files into haskell at compile time. A complete and utter hack job of course!

import Language.Haskell.TH
import Language.Haskell.TH.Quote

literally :: String -> Q Exp
literally = return . LitE . StringL

lit :: QuasiQuoter
lit = QuasiQuoter { quoteExp = literally }

litFile :: QuasiQuoter
litFile = quoteFile lit
