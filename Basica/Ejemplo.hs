module Basica.Ejemplo where
import Basica.Escher
import Dibujo
import Interp

type Basica = Escher

ejemplo :: Dibujo Basica
ejemplo = escher 2 True

interpBas :: Output Basica
interpBas True = trian2 -- se puede usar fShape, trian1... (en Inter.hs)

-- FIXME VACIA: se crashea

--interpBas :: Output Basica
--interpBas True = trian1

-- NOTE t1 AZUL
--ejemplo = Espejar (Rot45 (Basica True))

-- NOTE t1 ROJO (t2)
-- ejemplo = Rot90(Rot90(Rot90 (Espejar (Rot45 (Basica True))))) --  (Rot90 

-- NOTE Dibujo T (Ver my_img/Dibujo_T)
-- ejemplo = Encimar (Basica True) (Encimar t1 t2)
--    where t1 = Espejar (Rot45 (Basica True))
--          t2 = Rot90(Rot90(Rot90 t1))

-- NOTE Dibujo T consigna
dibT :: Dibujo Basica 
dibT = dibujoT (Basica True)

interpDibT :: Output Basica
interpDibT True = trian2
--ejemplo = Encimar (Basica True) (Encimar (Apilar 100 100 (Rot45 (Basica True)) (r270(Rot45 (Basica True)))))

-- NOTE Dibujo U
-- ejemplo = Encimar (Encimar p2 (Rot90 p2)) (Encimar (Rot90 (Rot90 p2)) (Rot90 (Rot90 (Rot90 p2))))
--     where p2 = Espejar (Rot45 (Basica True))

-- FIXME Probando, arreglar
--ejemplo = apilar 100 100 (juntar 100 100 (encimar4 (Basica fShape)) (encimar4 (Basica trian2))) (juntar 100 100 (encimar4 (Basica trianD)) (encimar4 (Basica rectan)))
