import Dibujo

p1 :: Pred Int
p1 = even

p2 :: Pred Int
p2 = (<) 10

test_andP :: Bool
test_andP =
    (andP p1 p2 1) == False &&
    (andP p1 p2 2) == False &&
    (andP p1 p2 10) == False &&
    (andP p1 p2 11) == False &&
    (andP p1 p2 12) == True &&
    (andP p1 p2 13) == False &&
    (andP p1 p2 14) == True 

test_orP :: Bool
test_orP = 
    (orP p1 p2 1) == False &&
    (orP p1 p2 2) == True &&
    (orP p1 p2 3) == False &&
    (orP p1 p2 4) == True &&
    (orP p1 p2 10) == True &&
    (orP p1 p2 11) == True &&
    (orP p1 p2 12) == True &&
    (orP p1 p2 13) == True &&
    (orP p1 p2 14) == True

test :: Bool
test = test_andP && test_orP