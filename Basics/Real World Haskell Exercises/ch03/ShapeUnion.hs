-- file: ch03/ShapeUnion.hs

type Vector = (Double, Double)

-- Values of type Shape can either be circles or
-- polygons, but not both.

data Shape = Circle Vector Double
           | Poly [Vector]
