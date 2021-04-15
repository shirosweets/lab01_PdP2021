module Main where
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Display
import Graphics.UI.GLUT.Begin
import Dibujo
import Interp
import qualified Basica.Ejemplo as E
import qualified Basica.Extra as Es

data Conf a = Conf {
    basic :: Output a
  , fig  :: Dibujo a
  , width :: Float
  , height :: Float
  }

escher x y = Conf {
                basic = E.interpBas
              , fig = E.ejemplo
              , width = x
              , height = y
              }

-- Dada una computación que construye una configuración, mostramos por
-- pantalla la figura de la misma de acuerdo a la interpretación para
-- las figuras básicas. Permitimos una computación para poder leer
-- archivos, tomar argumentos, etc.
initial :: IO (Conf E.Basica) -> IO ()
initial cf = cf >>= \cfg ->
                  let x  = width cfg
                      y  = height cfg
                  in display win white $ interp (basic cfg) (fig cfg) (0,0) (x,0) (0,y)
                  --in display win white . withGrid $ interp (basic cfg) (fig cfg) (0,0) (x,0) (0,y)
  where withGrid p = pictures [p, color grey $ grid 10 (0,0) 100 10]
        grey = makeColorI 120 120 120 120

win = InWindow "Grafico de Escher" (400, 400) (0, 0)
main = initial $ return (escher 100 100)
escherF = initial $ return (Conf {basic = Es.interpDib, fig = Es.escherF, width = 100, height = 100})
dibT = initial $ return (Conf {basic = E.interpDibT, fig = E.dibT, width = 100, height = 100})