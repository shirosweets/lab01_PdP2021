# Paradigmas de la programación - 2021
## Contenido
- [Información](#información)
- [¿Qué debe haber en el repositorio?](#¿qué-debe-haber-en-el-repositorio?)
- [¿Cómo añadir las funciones al test?](¿cómo-añadir-las-funciones-al-test?)
    - [Ejemplos para probar en la terminal](#ejemplos-para-probar-en-la-terminal)
- [¿Cómo probar la compilación?](#¿cómo-probar-la-compilación?)
- [¿Cómo correr el test?](#¿cómo-correr-el-test?)
- [¿Cómo checkear el tipo?](#¿cómo-checkear-el-tipo?)
- [¿Cómo limpiar la terminal?](#¿cómo-limpiar-la-terminal?)
- [Links](#links)
- [Info para leer](#info-para-leer)
- [Qué se evalúa y puntos extras](#qué-se-evalúa-y-puntos-extras)

## Información
Laboratorio Nº 1</p>
Grupo: 10</p>
Integrantes:
- Silva, Agustín
- Spitale, Alejandro
- Vispo, Valentina

## ¿Qué debe haber en el repositorio?

El contenido mínimo del repositorio debería ser el siguiente:

```
guide.md         # Guía breve realiza por los integrantes del grupo para agilizar
                 # las tareas
README.md        # Un readme breve donde comentan su experiencia y responden las 
	             # preguntas que están a continuación. Indicar acá si usan otra biblioteca.
Dibujo.hs        # Tipo de datos para <Figura> y todas las funciones
                 # relacionadas
Interp.hs        # Interpretación geométrica de las figuras, está bien
                 # si hay figuras que pueden servir para diferentes <Basica>
Basica/Escher.hs # Definición de combinadores, elección de tipo para 
                 # instanciar Dibujo, definción de la interpretación de 
                 # todas las figuras básicas.
Basica/Extra.hs  # Si se copan y hacen otros diseños, que estén en el
                 # directorio Basica.
Main.hs          # Definición del programa, configuración de parámetros.
```
## ¿Cómo compilar el Main.hs?
1) Escribir el ejemplo en `Ejemplo.hs`</p>
2) Correr:</p>
`ghci`</p>
`:l Main.hs`</p>
`main`
o
`ghci Main`</p>
`main`

## ¿Cómo añadir las funciones al test?
Vamos a distinguir 2 tipos de test:
- Test visual (dibujar en la grilla).
- Test no visual (sin dibujar en la grilla).

Existen 2 archivos de test no visuales: `Test.hs` y `TestInteractivo.hs`.</p>
Dónde `Test.hs` se definen las funciones a probar y se declaran los output y al final se checkean que los mismos coincidan con lo que debería dar.</p>
Mientras que `TestInteractivo.hs` funciona a través de la terminal.</p>

Test para funciones NO visuales con `Test.hs`:</p>
1) Dirigirse al archivo `Test.hs` (para las funciones básicas).
2) Añadir los tipos.
3) Añadir las funciones respetando los `input` y checkeando su `output`.

    `Test.hs` se corre de con:</p>
    `ghci Test`</p>
    `test_str test`</p>

Test para funciones NO visuales con `TestInteractivo.hs`:</p>
1) Dirigirse al archivo `TestInteractivo.hs`.
2) Definir un tipo `data` de figura con sus constructores (tomar de ejemplo a `data Triangulo`, `violeta`, `string`, etc.).
3) s
si cargan el archivo con `:l TestInteractivo.hs`, pueden hacer operaciones con los dibujos que definieron y comprobar que el resultado sea correcto, por ejemplo 

## Ejemplos para probar en la terminal
`ghci TestInteractivo`</p>
Ejemplo 1: 
```haskell
cambiar esRecto Escaleno d
```
Output esperado:</p>
```haskell
Encimar (Encimar (Apilar 1 1 (Rot45 (Basica Escaleno)) (Basica Escaleno)) (Juntar 1 1 (Basica IsocelesVioleta) (Basica Isoceles))) (Encimar (Basica Escaleno) (Basica EscalenoVioleta))
```
Ejemplo 2:</p>
```haskell
check (Rot90(Rot90(Rot90(Rot90 (Basica Recto)))))
```
Output esperado:</p>
```haskell
Left [RotacionSuperflua]
```
Ejemplo 3:</p>
```haskell
Encimar (Basica Escaleno) (Basica Isoceles)
```
Output esperado:</p>
```haskell
Encimar (Basica Escaleno) (Basica Isoceles)
```
Ejemplo 4:
```haskell
mapDib violeta (Encimar (Basica Escaleno) (Basica Isoceles))
```
Output esperado:</p>
```haskell
Encimar (Basica EscalenoVioleta) (Basica IsocelesVioleta)
```
Ejemplo 5:
```haskell
desc string (Apilar 10 10 (Encimar (Basica Recto) (Basica Escaleno)) (Basica Isoceles))
```
Output esperado:</p>
```haskell
"api x y (enc (Recto) (Escaleno)) (Isoceles)"
```

No existe un archivo como tal para correr test visuales pero se debe hacer lo siguiente para corrobar las funciones.</p>

Test para funciones visuales:
1) Dirigirse al archivo `Ejemplo.hs`
2) Crear una funcion de tipo `Dibujo Basica` por ejemplo 
```haskell
rot90 :: Dibujo Basica
rot90 = Basica 1 -- podemos pasar cualquier composicion, Espejar(Basica 1), etc
```
3) Agregar a la funcion `interpBas` el numero que utilizaron y dar una figura.
``` haskell
interpBas :: Output Basica
interpBas 1 = trian1 --(trian2, trianD, fShape, etc)
```
4) Luego ir al archivo `Main.hs` y añadir una linea al final del archivo para ejecutar esa función rot90 que creamos, de la siguiente manera:

rot90 = initial $ return (Conf {basic = E.interpBas, fig = E.`nombre de su funcion`, width = 100, height = 100})

5) Compilamos con </p>
`ghci`</p>
`:l Main.hs`</p>
`rot90`</p>

## ¿Cómo probar la compilación?
`ghci`</p>
`:l Test.hs`</p>
Para recargar la compilación:</p>
`:r`

## ¿Cómo correr el test de `Test.hs`?
`ghci`</p>
`:l Test.hs`</p>
`test_str test`</p>

## ¿Cómo checkear el tipo?
`ghci`</p>
`:l Test.hs`</p>
`:t <funcion>`</p>

Ejemplo:</p>
`:t orP` -> `orP :: Pred a -> Pred a -> Pred a`

## ¿Cómo limpiar la terminal?
Ctrl+L

## ¿Cómo cambiar el color de la grilla?
```haskell
initial :: IO (Conf E.Basica) -> IO ()
initial cf = cf >>= \cfg ->
                  let x  = width cfg
                      y  = height cfg
                  in display win white . withGrid $ interp (basic cfg) (fig cfg) (0,0) (x,0) (0,y)
          where withGrid p = pictures [p, Color yellow $ grid 10 (0,0) 100 10]
```

## ¿Cómo cambiar el color del dibujo?
```haskell
initial :: IO (Conf E.Basica) -> IO ()
initial cf = cf >>= \cfg ->
                  let x  = width cfg
                      y  = height cfg
                  in display win white (Color violet $ interp (basic cfg) (fig cfg) (0,0) (x,0) (0,y))
```

## Links
https://famaf.aulavirtual.unc.edu.ar/course/view.php?id=714</p>
https://wiki.uqbar.org/wiki/articles/data--definiendo-nuestros-tipos-en-haskell.html</p>
https://bitbucket.org/paradigmas-programacion-famaf/grupo10_lab01_2021/src/master/CONSIGNA.md</p>

## Info para leer
* [Expresiones del lenguaje](https://wiki.haskell.org/Category:Language_extensions)
* [Learn you a Haskell...](http://learnyouahaskell.com/) 
* [Aprende Haskell... (traducción del anterior)](http://aprendehaskell.es/main.html).
* [Real World Haskell](http://book.realworldhaskell.org/read/).
* [Buscador de funciones por tipo](https://www.haskell.org/hoogle/).
* [Guía de la sintaxis de Haskell](http://www.cse.chalmers.se/edu/year/2014/course/TDA452/haskell-syntax.html).
* [Documentación de gloss](http://hackage.haskell.org/package/gloss).
* https://hackage.haskell.org/package/base-4.15.0.0/docs/Data-Either.html
* https://stackoverflow.com/questions/6290712/using-either-in-haskell

#### Qué se evalúa y puntos extras

No se evaluarán proyectos que no se puedan compilar. La idea es que ningún
grupo llegue a este punto al momento de la entrega: pregunten temprano para
evitar esto. Hint: no intenten compilar al final. Como deben committear seguido, asegúrense que cada commit compile.

 * Que la elección de los tipos de datos sea la adecuada; en programación
   funcional esto es clave.

 * Que se comprendan los conceptos de funciones de alto orden y la forma en que
   se combinan funciones.

 * Que se haga buen reuso de funciones, es decir, que no reinventen una
   solución cada vez que se presente un mismo problema.

 * Que se pueda adaptar fácilmente a otros usos; en algún momento, antes de la
   entrega, liberaremos un archivo `Basica/Feo.hs` que use `Dibujo.hs` e
   `Interp.hs` que les permita testear.

 * Que el código sea elegante: líneas de tamaño razonable, buen espaciado, consistencia.

Se consiguen puntos extras si:

 * Hacen otra figura interesante, como una imagen fractal, explicando cada paso
   de su construcción.

 * Extienden el lenguaje para indicar animaciones de figuras. Hagan esto en un
   branch separado y comenten en el `README.md` de la branch `main` que lo
   hicieron.