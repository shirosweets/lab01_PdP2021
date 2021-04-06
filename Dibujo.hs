module Dibujo where

-- Definir el lenguaje.

-- LINK http://aprendehaskell.es/main.html
-- LINK https://famaf.aulavirtual.unc.edu.ar/course/view.php?id=714
-- LINK https://wiki.uqbar.org/wiki/articles/data--definiendo-nuestros-tipos-en-haskell.html
-- LINK https://bitbucket.org/paradigmas-programacion-famaf/grupo10_lab01_2021/src/master/CONSIGNA.md

-- ! NOTE Importante:
-- Nuestro lenguaje está parametrizado sobre una colección de figuras básicas
-- (representado por el no terminal `<Bas>`) y contiene _instrucciones_ para rotar
-- la imagen 90 grados, para espejarla horizontalmente, para rotarla 45 grados
-- (reduciendo su tamaño al mismo tiempo) y para combinar figuras. `Apilar` pone la
-- primer figura encima de la segunda, mientras que `Juntar` las coloca al lado;
-- estas dos instrucciones toman un par de enteros que indican la proporción del
-- tamaño de la primera y la segunda figura.

-- Usando este lenguaje podemos definir en Haskell funciones que combinan
-- programas `<Fig>` para producir otros. Usualmente esas funciones se
-- llaman _combinadores_. Por ejemplo, `rotar180 <Fig>` se define
-- fácilmente como la composición de `Rotar` con `Rotar`.

-- La semántica formal de las figuras básicas es una función que toma tres
-- vectores _a, b, c_ en ℝ² y produce una figura bi-dimensional donde
-- _a_ indica el desplazamiento del origen, _b_ el ancho y _c_ el alto.

-- Definir el lenguaje como un tipo de datos: como no sabemos a priori qué
-- Dibujos básicas tendremos, nuestro tipo de Dibujos debe ser _polimórfico_.

data Dibujo a = Vacia | Basica a | Rotar (Dibujo a) | Espejar (Dibujo a) | Rot45 (Dibujo a)
              | Apilar Int Int (Dibujo a) (Dibujo a)
              | Juntar Int Int (Dibujo a) (Dibujo a)
              | Encimar (Dibujo a) (Dibujo a)
              deriving (Eq, Show)

-- Constructores --

vacia :: a -> Dibujo a
vacia x = Vacia

basica :: a -> Dibujo a
basica x = Basica x

-- Gira 90º --
rotar :: Dibujo a -> Dibujo a
rotar x = Rotar x

espejar :: Dibujo a -> Dibujo a
espejar x = Espejar x

-- Gira 45º --
rot45 :: Dibujo a -> Dibujo a
rot45 x = Rot45 x

-- Poner una encima de la otra ocupando el mismo espacio --
-- `Apilar` pone la primer figura encima de la segunda
-- estas dos instrucciones toman un par de enteros que indican la proporción del
-- tamaño de la primera y la segunda figura.
apilar :: Int -> Int -> Dibujo a -> Dibujo a -> Dibujo a
apilar x y a b = Apilar x y a b

-- Pone una al lado de la otra --
-- `Juntar` las coloca al lado;
-- estas dos instrucciones toman un par de enteros que indican la proporción del
-- tamaño de la primera y la segunda figura.
juntar :: Int -> Int -> Dibujo a -> Dibujo a -> Dibujo a
juntar x y a b = Juntar x y a b

-- Pone una encima de la otra y no ocupan el mismo espacio ---
encimar :: Dibujo a -> Dibujo a -> Dibujo a
encimar a b = Encimar a b

-- ! TODO Definir los siguientes combinadores
-- * NOTE 1 Importante: todas estas serán utilizadas para los demás ejercicios
-- * es necesario por lo tanto hacerlos para casos b y n+1

-- Composición n-veces de una función con sí misma.
comp :: (a -> a) -> Int -> a -> a
comp f 0 x = x
comp f n x = comp f (n-1) (f(x))

-- Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 a = comp rotar 2 a

r270 :: Dibujo a -> Dibujo a
r270 a = comp rotar 3 a

-- Pone una Figura sobre la otra, ambas ocupan el mismo espacio. (apilar)
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = apilar 100 100 a b

-- Pone una Figura al lado de la otra, ambas ocupan el mismo espacio. (juntar)
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) a b = juntar 100 100 a b

-- Superpone una Figura con otra. (encimar)
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) a b = encimar a b

-- Dadas cuatro Dibujos las ubica en los cuatro cuadrantes.
-- Inicial
-- [abcd]
-- * P2
-- [a | b] [c | d]
---------------
-- []  []
-- * P3
-- [a | b]
   -------
-- [c | d]

cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = (.-.) ((///) a b) ((///) c d)

-- Una Figura repetida con las cuatro rotaciones, superpuestas.
-- Inicial
-- [ a | a | a | a ]
-- * Final
-- [ a | a > | a v | < a ] (una encima de la otra)
encimar4 :: Dibujo a -> Dibujo a
encimar4 a = (^^^) a ((^^^) ((^^^) (rotar a) (r180 a)) (r270 a))  -- ! FIXME Ver si tiene sentido

-- Cuadrado con la misma Figura rotada i * 90, para i ∈ {0, ..., 3}.
-- No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = (.-.) ((///) a (rotar a)) ((///) (r180 a) (r270 a))

-- ! TODO  Definir esquemas para la manipulación de Dibujos básicas.

-- Ver un a como una Figura.
pureDib :: a -> Dibujo a
pureDib a = Basica a

-- *
-- map para nuestro lenguaje.
--mapDib :: (a -> b) -> Dibujo a -> Dibujo b

-- Verificar que las operaciones satisfagan:
-- 1. mapDib id = id, donde id es la función identidad.
-- 2. mapDib (g ∘ f) = (mapDib g) ∘ (mapDib f).

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de intro a la lógica
--sem :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
--       (Int -> Int -> b -> b -> b) -> 
--       (Int -> Int -> b -> b -> b) -> 
--       (b -> b -> b) ->
--       Dibujo a -> b

-- * NOTE 1 Usando los esquemas anteriores, es decir no se puede hacer
-- * pattern-matching, definir estas funciones

type Pred a = a -> Bool

-- Dado un predicado sobre básicas, cambiar todas las que satisfacen
-- el predicado por la Dibujo básica indicada por el segundo argumento.
--cambiar :: Pred a -> a -> Dibujo a -> Dibujo a

-- Alguna básica satisface el predicado.
--anyDib :: Pred a -> Dibujo a -> Bool

-- Todas las básicas satisfacen el predicado.
--allDib :: Pred a -> Dibujo a -> Bool

-- Los dos predicados se cumplen para el elemento recibido.
--andP :: Pred a -> Pred a -> Pred a

-- Algún predicado se cumple para el elemento recibido.
--orP :: Pred a -> Pred a -> Pred a

-- Describe la Dibujo. Ejemplos: 
--   desc (const "b") (Basica b) = "b"
--   desc (const "b") (Rotar (Basica b)) = "rot (b)"
--   desc (const "b") (Apilar n m (Basica b) (Basica b)) = "api n m (b) (b)"
-- La descripción de cada constructor son sus tres primeros
-- símbolos en minúscula, excepto `Rot45` al que se le agrega el `45`.
--desc :: (a -> String) -> Dibujo a -> String

-- Junta todas las Dibujos básicas de un dibujo.
--basicas :: Dibujo a -> [a]

-- ! TODO Definir los siguientes predicados (pueden hacer pattern-matching).
-- !  Estos predicados indican una superfluocidad de operaciones (es
-- !  decir, cambian para no cambiar nada).

-- Hay 4 rotaciones seguidas.
--esRot360 :: Pred (Dibujo a)

-- Hay 2 espejados seguidos.
--esFlip2 :: Pred (Dibujo a)

-- ! TODO Definición de función que aplica un predicado y devuelve 
-- !  un error indicando fallo o una figura si no hay tal fallo.

--data Superfluo = RotacionSuperflua | FlipSuperfluo

-- Aplica todos los chequeos y acumula todos los errores, y
-- sólo devuelve la figura si no hubo ningún error.
--check :: Dibujo a -> Either [Superfluo] (Dibujo a) 
