module Basica.Ejemplo where
import Dibujo
import Interp

-- 

-- type Basica = ()
-- ejemplo :: Dibujo Basica
-- ejemplo = ()

-- interpBas :: Output Basica
-- interpBas () = trian1

data Triangulo = Isosceles | Escaleno | Recto

type Basica = Triangulo

ejemplo :: Dibujo Basica
ejemplo = Basica Isosceles

-- basica -> FP
-- TODO: Crear constructor
-- TODO: Definir como funciona el constructor
interpBas :: Output Basica
interpBas Isosceles = trian1 -- :t trian1 :: FloatingPic

-- TODO: Ver que compile el constructor
-- violeta :: Triangulo -> Triangulo
-- violeta Escaleno = EscalenoVioleta
-- violeta Recto = RectoVioleta
-- violeta t = t