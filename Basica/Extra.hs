module Basica.Extra where
import Basica.Escher
import Dibujo
import Interp

-- *NOTE: Si se copan y hacen otros diseños, que estén en el
-- directorio Basica.

escherF :: Dibujo Escher 
escherF = escher 10 True 

interpDib :: Output Escher 
interpDib True = fShape