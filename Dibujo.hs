module Dibujo where

-- *NOTE: Tipo de datos para <Figura> y todas las funciones relacionadas

-- Definir el lenguaje.

-- ! NOTE Importante:
-- Nuestro lenguaje está parametrizado sobre una colección de figuras básicas
-- (representado por el no terminal `<Bas>`) y contiene _instrucciones_ para Rot90
-- la imagen 90 grados, para espejarejarla horizontalmente, para Rot90la 45 grados
-- (reduciendo su tamaño al mismo tiempo) y para combinar figuras. `Apilar` pone la
-- primer figura encima de la segunda, mientras que `Juntar` las coloca al lado;
-- estas dos instrucciones toman un par de enteros que indican la proporción del
-- tamaño de la primera y la segunda figura.

-- Usando este lenguaje podemos definir en Haskell funciones que combinan
-- programas `<Fig>` para producir otros. Usualmente esas funciones se
-- llaman _combinadores_. Por ejemplo, `Rot90180 <Fig>` se define
-- fácilmente como la composición de `Rot90` con `Rot90`.

-- La semántica formal de las figuras básicas es una función que toma tres
-- vectores _a, b, c_ en ℝ² y produce una figura bi-dimensional donde
-- _a_ indica el despejarlazamiento del origen, _b_ el ancho y _c_ el alto.

-- Definir el lenguaje como un tipo de datos: como no sabemos a priori qué
-- Figuras básicas tendremos, nuestro tipo de Dibujos debe ser _polimórfico_.

data Dibujo a = Vacia 
              | Basica a
              | Rot90 (Dibujo a)
              | Espejar (Dibujo a)
              | Rot45 (Dibujo a)
              | Apilar Int Int (Dibujo a) (Dibujo a)
              | Juntar Int Int (Dibujo a) (Dibujo a)
              | Encimar (Dibujo a) (Dibujo a)
              deriving (Eq, Show)

-- ! TODO Definir los siguientes combinadores
-- * NOTE 1 Importante: todas estas serán utilizadas para los demás ejercicios
-- * es necesario por lo tanto hacerlos para casos b y n+1

-- | Composición n-veces de una función con sí misma.
comp :: (a -> a) -> Int -> a -> a
comp f 0 x = x
comp f n x = comp f (n-1) (f(x))

-- | Rotaciones de múltiplos de 90.
r180 :: Dibujo a -> Dibujo a
r180 a = comp Rot90 2 a

r270 :: Dibujo a -> Dibujo a
r270 a = comp Rot90 3 a

-- | Pone una Figura sobre la otra, ambas ocupan el mismo espacio. (apilar)
(.-.) :: Dibujo a -> Dibujo a -> Dibujo a
(.-.) a b = Apilar 100 100 a b

-- | Pone una Figura al lado de la otra, ambas ocupan el mismo espacio. (juntar)
(///) :: Dibujo a -> Dibujo a -> Dibujo a
(///) a b = Juntar 100 100 a b

-- | Superpone una Figura con otra. (Encimar)
(^^^) :: Dibujo a -> Dibujo a -> Dibujo a
(^^^) a b = Encimar a b

-- | Dadas cuatro Figuras las ubica en los cuatro cuadrantes.
cuarteto :: Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a -> Dibujo a
cuarteto a b c d = (.-.) ((///) a b) ((///) c d)
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

-- | Una Figura repetida con las cuatro rotaciones, superpuestas.
encimar4 :: Dibujo a -> Dibujo a
encimar4 a = (^^^) a ((^^^) ((^^^) (Rot90 a) (r180 a)) (r270 a))
-- Inicial
-- [ a | a | a | a ]
-- * Final
-- [ a | a > | a v | < a ] (una encima de la otra)

-- | Cuadrado con la misma Figura rotada i * 90, para i ∈ {0, ..., 3}. No confundir con encimar4!
ciclar :: Dibujo a -> Dibujo a
ciclar a = (.-.) ((///) a (r270 a)) ((///) (Rot90 a) (r180 a)) 

-- ! TODO  Definir esquemas para la manipulación de Dibujos básicas.

-- | Ver un a como una Figura.
pureDib :: a -> Dibujo a
pureDib a = Basica a

-- *
-- | map para nuestro lenguaje.
mapDib :: (a -> b) -> Dibujo a -> Dibujo b
mapDib f Vacia = Vacia
mapDib f (Basica a) = pureDib (f a)
mapDib f (Rot90 a) = Rot90 (mapDib f a)
mapDib f (Espejar a) = Espejar (mapDib f a)
mapDib f (Rot45 a) = Rot45 (mapDib f a)
mapDib f (Apilar x y a b) = Apilar x y (mapDib f a) (mapDib f b)
mapDib f (Juntar x y a b) = Juntar x y (mapDib f a) (mapDib f b)
mapDib f (Encimar a b)  = Encimar (mapDib f a) (mapDib f b)


-- Verificar que las operaciones satisfagan:
-- 1. mapDib id = id, donde id es la función identidad.
-- 2. mapDib (g ∘ f) = (mapDib g) ∘ (mapDib f).

-- Estructura general para la semántica (a no asustarse). Ayuda: 
-- pensar en foldr y las definiciones de intro a la lógica
sem :: (a -> b) -> (b -> b) -> (b -> b) -> (b -> b) ->
       (Int -> Int -> b -> b -> b) -> 
       (Int -> Int -> b -> b -> b) -> 
       (b -> b -> b) ->
       Dibujo a -> b
sem bas r90 esp r45 api jun enc (Basica a) = bas a
sem bas r90 esp r45 api jun enc (Rot90 a) = r90 (sem bas r90 esp r45 api jun enc a)
sem bas r90 esp r45 api jun enc (Espejar a) = esp (sem bas r90 esp r45 api jun enc a)
sem bas r90 esp r45 api jun enc (Rot45 a) = r45 (sem bas r90 esp r45 api jun enc a)
sem bas r90 esp r45 api jun enc (Apilar x y a b) = api x y (sem bas r90 esp r45 api jun enc a) (sem bas r90 esp r45 api jun enc b)
sem bas r90 esp r45 api jun enc (Juntar x y a b) = jun x y (sem bas r90 esp r45 api jun enc a) (sem bas r90 esp r45 api jun enc b)
sem bas r90 esp r45 api jun enc (Encimar a b) = enc (sem bas r90 esp r45 api jun enc a) (sem bas r90 esp r45 api jun enc b)
--bas -> Basica
--r90 -> Rot90
--r45 -> Rot45
--api -> Apilar
--esp -> Espejar
--jun -> Juntar
--enc -> Encimar

-- * NOTE 1 Usando los esquemas anteriores, es decir no se puede hacer
-- * pattern-matching, definir estas funciones

type Pred a = a -> Bool

{- |  
   Dado un predicado sobre básicas, cambiar todas las que satisfacen
   el predicado por la figura básica indicada por el segundo argumento.
-}
cambiar :: Pred a -> a -> Dibujo a -> Dibujo a
cambiar p a b = mapDib (fun_cambia p a) b

fun_cambia :: Pred a -> a -> a -> a
fun_cambia p a b | p b = a
                 | otherwise = b

-- | Alguna básica satisface el predicado.   NOTE anyDib testeada
anyDib :: Pred a -> Dibujo a -> Bool
anyDib p a = sem p bool_any_1 bool_any_1 bool_any_1 bool_any_2 bool_any_2 bool_any_3 a

bool_any_1 :: Bool -> Bool
bool_any_1 x = x

bool_any_2 :: Int -> Int -> Bool -> Bool -> Bool
bool_any_2 _ _ x y = x || y

bool_any_3 :: Bool -> Bool -> Bool
bool_any_3 x y = x || y

-- | Todas las básicas satisfacen el predicado. NOTE allDib testeada
allDib :: Pred a -> Dibujo a -> Bool
allDib p a = sem p bool_all_1 bool_all_1 bool_all_1 bool_all_2 bool_all_2 bool_all_3 a

bool_all_1 :: Bool -> Bool
bool_all_1 x = x

bool_all_2 :: Int -> Int -> Bool -> Bool -> Bool
bool_all_2 _ _ x y = x && y

bool_all_3 :: Bool -> Bool -> Bool
bool_all_3 x y = x && y

-- | Los dos predicados se cumplen para el elemento recibido. NOTE andP testeada
andP :: Pred a -> Pred a -> Pred a
andP p1 p2 x = p1 x && p2 x

-- | Algún predicado se cumple para el elemento recibido.     NOTE orP testeada
orP :: Pred a -> Pred a -> Pred a
orP p1 p2 x = p1 x || p2 x

-- Describe la figura. Ejemplos: 
--   desc (const "b") (Basica b) = "b"
--   desc (const "b") (Rotar (Basica b)) = "rot (b)"
--   desc (const "b") (Apilar n m (Basica b) (Basica b)) = "api n m (b) (b)"
-- La descripción de cada constructor son sus tres primeros
-- símbolos en minúscula, excepto `Rot45` al que se le agrega el `45`.
-- NOTE desc testeada

desc :: (a -> String) -> Dibujo a -> String
desc f a = sem f descRot90 descEsp descRot45 descApi descJun descEnc a

descRot90 :: String -> String
descRot90 a = "rot" ++ " " ++ "(" ++ a ++ ")"

descEsp :: String -> String
descEsp a = "esp" ++ " " ++ "(" ++ a ++ ")"

descRot45 :: String -> String
descRot45 a = "rot45" ++ " " ++ "(" ++ a ++ ")"

descApi :: Int -> Int -> String -> String -> String
descApi x y a b = "api" ++ " " ++ "x" ++ " " ++ "y" ++ " " ++ "(" ++ a ++ ")" ++ " " ++ "(" ++ b ++ ")"

descJun :: Int -> Int -> String -> String -> String
descJun x y a b = "jun" ++ " " ++ "x" ++ " " ++ "y" ++ " " ++ "(" ++ a ++ ")" ++ " " ++ "(" ++ b ++ ")"

descEnc :: String -> String -> String
descEnc a b = "enc" ++ " " ++ "(" ++ a ++ ")" ++ " " ++ "(" ++ b ++ ")"

-- | Junta todas las Figuras básicas de un dibujo.    NOTE Basicas testeada

basicas :: Dibujo a -> [a]
basicas = sem basicasbas basicas2 basicas2 basicas2 basicas3 basicas3 basicas4

basicasbas :: a -> [a]
basicasbas a = [a]

basicas2 :: a -> a
basicas2 a = a

basicas3 :: Int -> Int -> [a] -> [a] -> [a]
basicas3 a b xs ys = xs ++ ys

basicas4 :: [a] -> [a] -> [a]
basicas4 xs ys = xs ++ ys


-- ! TODO Definir los siguientes predicados (pueden hacer pattern-matching).
-- !  Estos predicados indican una superfluocidad de operaciones (es
-- !  decir, cambian para no cambiar nada).

-- | Hay 4 rotaciones seguidas. Dibujo (a) -> Bool NOTE esRot360 testeada
esRot360 :: Pred (Dibujo a)
esRot360 (Rot90 (Rot90 (Rot90 (Rot90 a)))) = True
esRot360 Vacia = False
esRot360 (Basica a) = False
esRot360 (Rot90 a) = esRot360 a
esRot360 (Espejar a) = esRot360 a
esRot360 (Rot45 a) = esRot360 a
esRot360 (Apilar x y a b) = esRot360 a || esRot360 b
esRot360 (Juntar x y a b) = esRot360 a || esRot360 b
esRot360 (Encimar a b) = esRot360 a || esRot360 b

-- | Hay 2 espejados seguidos. NOTE esFlip2 testeada
esFlip2 :: Pred (Dibujo a)
esFlip2 (Espejar(Espejar a)) = True
esFlip2 Vacia = False
esFlip2 (Basica a) = False
esFlip2 (Rot90 a) = esFlip2 a
esFlip2 (Espejar a) = esFlip2 a
esFlip2 (Rot45 a) = esFlip2 a
esFlip2 (Apilar x y a b) = esFlip2 a || esFlip2 b
esFlip2 (Juntar x y a b) = esFlip2 a || esFlip2 b
esFlip2 (Encimar a b) = esFlip2 a || esFlip2 b

-- ! TODO Definición de función que aplica un predicado y devuelve 
-- !  un error indicando fallo o una figura si no hay tal fallo.

data Superfluo = RotacionSuperflua | FlipSuperfluo
               deriving Show
{- |
   Aplica todos los chequeos y acumula todos los errores, y

   sólo devuelve la figura si no hubo ningún error.
-}
-- NOTE check testeada
check :: Dibujo a -> Either [Superfluo] (Dibujo a)
check a | esRot360 a && esFlip2 a = Left [RotacionSuperflua, FlipSuperfluo]
        | esRot360 a = Left [RotacionSuperflua]
        | esFlip2 a = Left [FlipSuperfluo]
        | otherwise = Right a
