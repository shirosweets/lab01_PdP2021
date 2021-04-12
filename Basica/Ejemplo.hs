module Basica.Ejemplo where
import Basica.Escher
import Dibujo
import Interp

type Basica = Escher

ejemplo :: Dibujo Basica
ejemplo = escher 2 True
--ejemplo = apilar 100 100 (juntar 100 100 (encimar4 (Basica fShape)) (encimar4 (Basica trian2))) (juntar 100 100 (encimar4 (Basica trianD)) (encimar4 (Basica rectan)))
--ejemplo = Encimar (Encimar p2 (Rot90 p2) ) (Encimar (Rot90 (Rot90 p2)) (Rot90 (Rot90 (Rot90 p2))))
    --where p2 = Espejar (Rot45 (Basica True))
--ejemplo = Encimar (Basica True) (Encimar t1 t2)  
--    where t1 = Espejar (Rot45 (Basica True))
--          t2 = Rot90(Rot90(Rot90 t1))

interpBas :: Output Basica
interpBas True = fShape
