module Basica.Ejemplo where
import Basica.Escher
import Dibujo
import Interp

type Basica = Escher;



ejemplo :: Dibujo Basica
ejemplo = Rot90 (Basica True)


interpBas :: Output Basica
interpBas True = trian1