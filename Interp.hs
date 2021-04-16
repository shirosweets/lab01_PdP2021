module Interp where
import Graphics.Gloss
import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Geometry.Angle
import qualified Graphics.Gloss.Data.Point.Arithmetic as V

import Dibujo
type FloatingPic = Vector -> Vector -> Vector -> Picture
type Output a = a -> FloatingPic

-- el vector nulo
zero :: Vector
zero = (0, 0)

half :: Vector -> Vector
half = (0.5 V.*)

raiz :: Vector -> Vector
raiz = (sqrt (3/2) V.*)

-- comprender esta función es un buen ejericio.
hlines :: Vector -> Float -> Float -> [Picture]
hlines (x, y) mag sep = map (hline . (* sep)) [0..]
      where hline h = line [(x, y + h), (x + mag, y + h)] 

-- Una grilla de n líneas, comenzando en v con una separación de sep y
-- una longitud de l (usamos composición para no aplicar este argumento)
grid :: Int -> Vector -> Float -> Float -> Picture
grid n v sep l = pictures [ls, translate 0 (l * toEnum n) (rotate 90 ls)]
      where ls = pictures $ take (n + 1) $ hlines v sep l

-- figuras adaptables comunes
-- | Triangulo isoceles
trian1 :: FloatingPic
trian1 a b c = line $ map (a V.+) [zero, half b V.+ c, b , zero]

-- | Triangulo rectangulo
trian2 :: FloatingPic
trian2 a b c = line $ map (a V.+) [zero, c, b, zero] -- [zero, half a V.+ b, b V.+ c, zero]

-- | Triangulo escaleno
trian3 :: FloatingPic
trian3 a b c = line $ map (a V.+) [zero, raiz (raiz b), half (b V.+ c), zero]

-- | Triangulo isoceles dado vuelta
trianD :: FloatingPic
trianD a b c = line $ map (a V.+) [c, half b , b V.+ c, c]

-- | Rectangulo
rectan :: FloatingPic
rectan a b c = line [a, a V.+ b, a V.+ b V.+ c, a V.+ c, a]

simple :: Picture -> FloatingPic
simple p _ _ _ = p

-- | Figura F
fShape :: FloatingPic
fShape a b c = line . map (a V.+) $ [ zero,uX, p13, p33, p33 V.+ uY , p13 V.+ uY 
                 , uX V.+ 4 V.* uY ,uX V.+ 5 V.* uY, x4 V.+ y5
                 , x4 V.+ 6 V.* uY, 6 V.* uY, zero]    
  where p33 = 3 V.* (uX V.+ uY)
        p13 = uX V.+ 3 V.* uY
        x4 = 4 V.* uX
        y5 = 5 V.* uY
        uX = (1/6) V.* b
        uY = (1/6) V.* c

-- Dada una función que produce una figura a partir de un a y un vector
-- producimos una figura flotante aplicando las transformaciones
-- necesarias. Útil si queremos usar figuras que vienen de archivos bmp.
transf :: (a -> Vector -> Picture) -> a -> Vector -> FloatingPic
transf f d (xs,ys) a b c  = translate (fst a') (snd a') .
                             scale (magV b/xs) (magV c/ys) .
                             rotate ang $ f d (xs, ys)
  where ang = radToDeg $ argV b
        a' = a V.+ half (b V.+ c)

--Operaciones con vectores : Suma -> V.+
--                           Multiplicacion V.*
--                           Negative V.negate
--                           Resta V.-
-- interp :: Output() -> Output (Dibujo ())
-- interp f () = f ()

interp :: Output a -> Output (Dibujo a)
interp f Vacia = simple blank
interp f (Basica a) = f a
interp f (Rot90 a) = interpRot90 (interp f a)
interp f (Rot45 a) = interpRot45 (interp f a)
interp f (Espejar a) = interpEspejar (interp f a)
interp f (Apilar x y a b) = interpApilar x y (interp f a) (interp f b)
interp f (Juntar x y a b) = interpJuntar x y (interp f a) (interp f b)
interp f (Encimar a b) = interpEncimar (interp f a) (interp f b)

interpRot90 :: FloatingPic -> FloatingPic
interpRot90 f x y z = f (x V.+ y) z (V.negate y)

interpRot45 :: FloatingPic -> FloatingPic
interpRot45 f x y z = f (x V.+ half(y V.+ z)) (half (y V.+ z)) (half (z V.- y))

interpEspejar :: FloatingPic -> FloatingPic
interpEspejar f x y z = f (x V.+ y) (V.negate y) z

interpApilar :: Int -> Int -> FloatingPic -> FloatingPic -> FloatingPic
interpApilar n m f1 f2 x y z = pictures [f1 (x V.+ z') y (r V.* z),f2 x y z']
      where l = toFloat m
            p = toFloat n
            r = p/(p+l)
            r' = l/(p+l)
            z' = r' V.* z

interpJuntar :: Int -> Int -> FloatingPic -> FloatingPic -> FloatingPic
interpJuntar n m f1 f2 x w h = pictures [f1 x w' h, f2 (x V.+ w') (r' V.* w) h]
      where l = toFloat m
            p = toFloat n
            r' = l/(p+l)
            r = p/(p+l)
            w' = r V.* w

interpEncimar :: FloatingPic -> FloatingPic -> FloatingPic
interpEncimar f1 f2 x y z = pictures[f1 x y z, f2 x y z]

toFloat :: Int -> Float
toFloat n = fromInteger (toInteger n)