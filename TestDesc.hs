module TestDesc where
import Dibujo

-- están mezclando el tipo Dibujo con su interpretación, acá no hay que usar rotar, 
-- que es una función particular de la interpretación de Dibujo con figuras de Gloss....
-- La estructura de la función map es recursiva, así que sí, como vos decís, van a tener que definir un caso para cada constructor.
-- Les dejo un ejemplo para completar:
-- Supongamos que tenemos un tipo de básica que sea type Triangulo = Escaleno | Recto | RectoVioleta | EscalenoVioleta.
-- Usando la definición mapDib :: (a -> b) -> Dibujo a -> Dibujo b, pongamos una función violeta para aplicar que cambie
-- los triángulos adentro de un Dibujo.

data Triangulo = Escaleno | Recto | Isoceles | RectoVioleta | EscalenoVioleta | IsocelesVioleta
                deriving (Eq,Show)

violeta :: Triangulo -> Triangulo
violeta Escaleno = EscalenoVioleta
violeta Recto = RectoVioleta
violeta Isoceles = IsocelesVioleta
violeta t = t

-- Ahora vamos a querer aplicar violeta a cada elemento de un Dibujo usando mapDib. Empecemos por el caso base:
-- mapDib violeta (Basica Recto) qué resultado tiene que dar? y `mapDib violeta (Rotar (Basica Recto))?
-- Cómo definen mapDib para lograr ese resultado?

-- TODO
-- Hola! Pueden crearse un archivito de prueba con ejemplos, o escribirlo en la consola interactiva del ghci. 
-- Dentro de ese archivo, pueden crear dibujos y aplicarles las funciones. Por ejemplo, si quieren probar anyDib:

esRecto :: Pred Triangulo
esRecto a = a == Recto

d :: Dibujo Triangulo
d = Encimar (Encimar (Apilar 1 1 (Rot45(Basica Recto)) (Basica Recto) ) (Juntar 1 1 (Basica IsocelesVioleta) (Basica Isoceles)) ) (Encimar (Basica Recto) (Basica EscalenoVioleta))

string :: Triangulo -> String
string Recto = "Recto"
string Escaleno = "Escaleno"
string Isoceles = "Isoceles"

-- si cargan el archivo de ejemplo con :l, pueden hacer operaciones con los dibujos que definieron y comprobar que el 
-- resultado sea correcto, por ejemplo cambiar esRecto Escaleno d == Encimar (Basica Escaleno) (Basica Isoceles)

-- Describe la figura. Ejemplos: 
--   desc (const "b") (Basica b) = "b"
--   desc (const "b") (Rotar (Basica b)) = "rot (b)"
--   desc (const "b") (Apilar n m (Basica b) (Basica b)) = "api n m (b) (b)"
-- La descripción de cada constructor son sus tres primeros
-- símbolos en minúscula, excepto `Rot45` al que se le agrega el `45`.
-- desc :: (a -> String) -> Dibujo a -> String

-- test :: Pred a -> Dibujo a -> Dibujo a
-- test = cambiar p b = mapDib (Triangulo p a) b