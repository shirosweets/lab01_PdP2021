# Paradigmas de la programación - 2021
# Contenido
- [Información](#información)
- [¿Cómo añadir las funciones al test?](¿cómo-añadir-las-funciones-al-test?)
- [¿Cómo probar la compilación?](#¿cómo-probar-la-compilación?)
- [¿Cómo correr el test?](#¿cómo-correr-el-test?)
- [¿Cómo checkear el tipo?](#¿cómo-checkear-el-tipo?)
- [¿Cómo limpiar la terminal?](#¿cómo-limpiar-la-terminal?)
- [Info para leer](#info-para-leer)

## Información
Laboratorio Nº 1<p/>
Grupo: 10<p/>
Integrantes:
- Silva, Agustín
- Spitale, Alejandro
- Vispo, Valentina

## ¿Cómo añadir las funciones al test?
1) Dirigirse al archivo `Test.hs`
2) Añadir los tipos
3) Añadir las funciones respetando los `input` y checkeando su `output`. 

## ¿Cómo probar la compilación?
`ghci`<p/>
`:l Test.hs`<p/>
Para recargar la compilación:<p/>
`:r`

## ¿Cómo correr el test?
`ghci`<p/>
`:l Test.hs`<p/>
`test_str test`<p/>
## ¿Cómo checkear el tipo?
`ghci`<p/>
`:l Test.hs`<p/>
`:t <funcion>`<p/>

Ejemplo:</p>
`:t orP` -> `orP :: Pred a -> Pred a -> Pred a`

## ¿Cómo limpiar la terminal?
Ctrl+L
## Info para leer
* [Expresiones del lenguaje](https://wiki.haskell.org/Category:Language_extensions)
* [Learn you a Haskell...](http://learnyouahaskell.com/) 
* [Aprende Haskell... (traducción del anterior)](http://aprendehaskell.es/main.html).
* [Real World Haskell](http://book.realworldhaskell.org/read/).
* [Buscador de funciones por tipo](https://www.haskell.org/hoogle/).
* [Guía de la sintaxis de Haskell](http://www.cse.chalmers.se/edu/year/2014/course/TDA452/haskell-syntax.html).
* [Documentación de gloss](http://hackage.haskell.org/package/gloss).