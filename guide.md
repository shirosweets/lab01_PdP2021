# Paradigmas de la programación - 2021
# Contenido
- [Información](#información)
- [Qué debe haber en el repositorio](#qué-debe-haber-en-el-repositorio)
- [¿Cómo añadir las funciones al test?](¿cómo-añadir-las-funciones-al-test?)
- [¿Cómo probar la compilación?](#¿cómo-probar-la-compilación?)
- [¿Cómo correr el test?](#¿cómo-correr-el-test?)
- [¿Cómo checkear el tipo?](#¿cómo-checkear-el-tipo?)
- [¿Cómo limpiar la terminal?](#¿cómo-limpiar-la-terminal?)
- [Links](#links)
- [Info para leer](#info-para-leer)

## Información
Laboratorio Nº 1</p>
Grupo: 10</p>
Integrantes:
- Silva, Agustín
- Spitale, Alejandro
- Vispo, Valentina

#### Qué debe haber en el repositorio

El contenido mínimo del repositorio debería ser el siguiente:

```
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


## ¿Cómo añadir las funciones al test?
1) Dirigirse al archivo `Test.hs`
2) Añadir los tipos
3) Añadir las funciones respetando los `input` y checkeando su `output`. 

## ¿Cómo probar la compilación?
`ghci`</p>
`:l Test.hs`</p>
Para recargar la compilación:</p>
`:r`

## ¿Cómo correr el test?
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