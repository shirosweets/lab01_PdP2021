# Paradigmas de la programación - 2021
# Contenido
- [Información](#información)
- [¿Cómo añadir las funciones al test?](¿cómo-añadir-las-funciones-al-test?)
- [¿Cómo probar la compilación?](#¿cómo-probar-la-compilación?)
- [¿Cómo checkear el tipo?](#¿cómo-checkear-el-tipo?)

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
`:l Test.hs`

## ¿Cómo checkear el tipo?
`ghci`<p/>
`:l Test.hs`<p/>
`:t <funcion>`<p/>

Ejemplo:</p>
`:t orP` -> `orP :: Pred a -> Pred a -> Pred a`