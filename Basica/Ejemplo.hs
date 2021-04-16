module Basica.Ejemplo where
import Basica.Escher
import Dibujo
import Interp

type Basica = Escher

ejemplo :: Dibujo Basica
ejemplo = escher 2 1

escherF :: Dibujo Escher 
escherF = escher 5 2

interpBas :: Output Basica
interpBas 1 = trian2 -- se puede usar fShape, trian1... (en Inter.hs)
interpBas 2 = fShape
