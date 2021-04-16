module Basica.Escher where
import Graphics.Gloss
import Dibujo
{-
Usos

La primer tarea es reconstruir el gráfico de Escher (con triángulos). 
para eso se debe crear un módulo Escher.hs en /Basica donde definen un sínonimo de tipos adecuado e implementan los siguientes combinadores, 
en función de la siguiente descripción de los dos primeros niveles:

lado(1, f) = cuarteto(blank, blank, rot(f), f)

lado(2, f) = cuarteto(lado(1, f), lado(1, f), rot(f), f)

esquina(1, f) = cuarteto(blank, blank, blank, dibujo_u(p))

esquina(2, f) = cuarteto(esquina(1, f), lado(1, f), rot(lado(1, f)), dibujo_u(f))

para esto también necesitan las figuras u y t del paper de Henderson, que nosotros las generalizamos un poco, en azul se muestra la figura original.
https://cs.famaf.unc.edu.ar/~mpagano/henderson-funcgeo2.pdf

-}

--type Floatingpic = Vector -> Vector -> Vector -> picture
type Escher = Int

-- El dibujoU.
dibujoU :: Dibujo Escher -> Dibujo Escher
dibujoU p = Encimar (Encimar p1 (Rot90 p1)) (Encimar (Rot90 (Rot90 p1)) (Rot90 (Rot90 (Rot90 p1))) )
        where p1 = Espejar (Rot45 p)

-- El dibujoU de la consigna (profes)
--dibujoUConsigna :: Dibujo Escher -> Dibujo Escher
--dibujoUConsigna p = ciclar p

-- El dibujo t.
dibujoT :: Dibujo Escher -> Dibujo Escher
dibujoT t = Encimar t (Encimar t1 t2)  
    where t1 = Espejar (Rot45 t)
          t2 = r270 t1

-- Esquina con nivel de detalle en base a la figura p.
esquina :: Int -> Dibujo Escher -> Dibujo Escher
--esquina 1 p = cuarteto Vacia Vacia Vacia (dibujoU p)
esquina 0 _ = Vacia 
esquina n p = cuarteto (esquina (n-1) p) (lado (n-1) p) (Rot90 (lado (n-1) p)) (dibujoU p)

-- Lado con nivel de detalle.
lado :: Int -> Dibujo Escher -> Dibujo Escher
lado 0 _ = Vacia
lado n p = cuarteto (lado (n-1) p) (lado (n-1) p) (Rot90 (dibujoT p)) (dibujoT p)

--noneto p q r s t u v w x = undefined
noneto p q r s t u v w x = Apilar 1 2
                        (Juntar 1 2 p (Juntar 1 1 q r))
                        (Apilar 1 1 (Juntar 1 2 s (Juntar 1 1 t u)) (Juntar 1 2 v (Juntar 1 1 w x)))

-- El dibujo de Escher: squarelimit
escher :: Int -> Escher -> Dibujo Escher
escher n p = noneto (esquina n (Basica p))
                (lado n (Basica p))
                (Rot90(Rot90(Rot90 (esquina n (Basica p)))))
                (Rot90 (lado n (Basica p)))
                (dibujoU (Basica p))
                (Rot90(Rot90(Rot90 (lado n (Basica p)))))
                (Rot90 (esquina n (Basica p)))
                (Rot90(Rot90(lado n (Basica p))))
                (Rot90(Rot90(esquina n (Basica p))))
