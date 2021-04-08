import Dibujo

-- | Define una figura básica
bas1 :: Dibujo Int
bas1 = Basica 1

bas2 :: Dibujo Int
bas2 = Basica 2

bas3 :: Dibujo Int
bas3 = Rot90(Rot90(Rot90(Rot90 bas1)))

bas4 :: Dibujo Int
bas4 = Basica 4

-- | Para espejar
bas5 :: Dibujo Int
bas5 = Espejar(Espejar bas1)

-- | Test de composición
test_comp :: Bool
test_comp =
    (comp ((+) 1) 4 0) == 4 &&
    (comp ((*) 1) 4 0) == 0 &&
    (comp ((+) 2) 4 1) == 9 &&
    (comp (\n -> n `div` 2) 3 8) == 1 &&
    (comp (\n -> n `div` 2) 2 16) == 4 &&
    (comp (\s -> "s" ++ s) 5 "") == "sssss"

-- | Test Rotar 180
test_r180 :: Bool
test_r180 = r180 bas1 == Rot90 (Rot90 bas1)

-- | Predicado 1
p1 :: Pred Int
p1 = even

-- | Predicado 2 --
p2 :: Pred Int
p2 = (<) 10

andfunc :: Pred Int
andfunc = andP even ((<) 10)

-- | Test andP
test_andP :: Bool
test_andP =
    andfunc 1 == False &&
    andfunc 2 == False &&
    andfunc 10 == False &&
    andfunc 11 == False &&
    andfunc 12 == True &&
    andfunc 13 == False &&
    andfunc 14 == True 

orfunc :: Pred Int
orfunc = orP even ((<) 10)

-- | Test orP
test_orP :: Bool
test_orP = 
    orfunc 1 == False &&
    orfunc 2 == True &&
    orfunc 3 == False &&
    orfunc 4 == True &&
    orfunc 10 == True &&
    orfunc 11 == True &&
    orfunc 12 == True &&
    orfunc 13 == True &&
    orfunc 14 == True

-- | Test esRot360
test_esRot360 :: Bool
test_esRot360 =
    esRot360 (bas3) == True &&
    esRot360 (bas1) == False

-- | Test esFlip2
test_esFlip2 :: Bool
test_esFlip2 =
    esFlip2 (bas1) == False &&
    esFlip2 (bas3) == False &&
    esFlip2 (bas5) == True

{- |
    Función para correr los test

    Devuelve True si corren bien.
-}
test :: Bool
test = 
    test_comp &&
    test_r180 &&
    test_andP &&
    test_orP &&
    test_esRot360 &&
    test_esFlip2

{- |
    Función que manda un mensaje según el resultado de los test
-}
test_str :: Bool-> String
test_str b | b == True = "Esta todo bien (^-^)/ ~naisu"
           | otherwise = "Algo salio mal (u_u)"