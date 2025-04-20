module Graphics.Implicit.CSG
  
import Graphics.Implicit.Shape

public export
union : Shape -> Shape -> Shape
union x y = min x y
  
public export
intersection : Shape -> Shape -> Shape
intersection x y = max x y
  
public export
inverse : Shape -> Shape
inverse x = neg x
  
public export
difference : Shape -> Shape -> Shape
difference x y = intersection x (inverse y)

public export
offset : Shape -> Shape -> Shape
offset x y = x - y
  
public export
clearance : Shape -> Shape -> Shape -> Shape
clearance x y z = difference x $ offset y z

public export
shell : Shape -> Shape -> Shape
shell x y = clearance x x $ neg $ abs y
  
public export
blendExpt : Shape -> Shape -> Shape -> Shape
blendExpt x y z = neg $ (exp (neg z) * x) + (exp (neg z) * y) / z

blendExptUnit : Shape -> Shape -> Shape -> Shape
blendExptUnit x y z = blendExpt x y $ (Cn ?aaa) / pow z (Cn ?bbb)

public export
blendRough : Shape -> Shape -> Shape -> Shape
blendRough x y z = 
  let c  = (sqrt (abs x)) + (sqrt (abs y)) - z
  in union x $ union y c

blendDifference : Shape -> Shape -> Shape -> Shape -> Shape
blendDifference x y z w = inverse $ blendExptUnit (inverse x) (offset y w) z
  
public export
morph : Shape -> Shape -> Shape -> Shape
morph x y z = x * (Cn 1 - z) + y * z

loft : Shape -> Shape -> Shape -> Shape -> Shape
loft x y z w = ?loft_rhs
  
loftBetween : Shape -> Shape -> Shape -> Shape -> Shape
loftBetween x y z w = ?loftBetween_rhs
