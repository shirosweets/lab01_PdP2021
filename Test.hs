import Dibujo

-- | Define una figura básica
bas1 :: Dibujo Int
bas1 = Basica 1

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

{- |
    Función para correr los test

    Devuelve True si corren bien.
-}
test :: Bool
test = 
    test_comp &&
    test_r180 &&
    test_andP &&
    test_orP

test_str :: Bool-> String
test_str b | b == True = "Esta todo bien (^-^)/"
           | otherwise = "Algo salió mal (u_u)"