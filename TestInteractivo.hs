module TestInteractivo where
import Dibujo

data Triangulo = Escaleno | Recto | Isoceles | RectoVioleta | EscalenoVioleta | IsocelesVioleta
                deriving (Eq,Show)

violeta :: Triangulo -> Triangulo
violeta Escaleno = EscalenoVioleta
violeta Recto = RectoVioleta
violeta Isoceles = IsocelesVioleta
violeta t = t

esRecto :: Pred Triangulo
esRecto a = a == Recto

d :: Dibujo Triangulo
d = Encimar (Encimar (Apilar 1 1 (Rot45(Basica Recto)) (Basica Recto) ) (Juntar 1 1 (Basica IsocelesVioleta) (Basica Isoceles)) ) (Encimar (Basica Recto) (Basica EscalenoVioleta))

string :: Triangulo -> String
string Recto = "Recto"
string Escaleno = "Escaleno"
string Isoceles = "Isoceles"

-- *NOTE Añadir acá tus tipos y funciones de test
