module Graphics.L5.Stdlib
  
import System.FFI
import Graphics.L5.Lib

public export
stdlib : String -> String
stdlib fn = ffi fn "libfive-stdlib.so"

public export
TFloat : Type
TFloat = L5Tree

public export
TVec2 : Type
public export
TVec3 : Type

TVec2 = 
  Struct "tvec2" 
    [ ("x", TFloat)
    , ("y", TFloat)
    ]

TVec3 = 
  Struct "tvec3" 
    [ ("x", TFloat)
    , ("y", TFloat)
    , ("z", TFloat)
    ]


-- csg
public export
%foreign (stdlib "_union")
union : L5Tree -> L5Tree -> L5Tree

public export
%foreign (stdlib "intersection")
intersection : L5Tree -> L5Tree -> L5Tree

public export
%foreign (stdlib "inverse")
inverse : L5Tree -> L5Tree

public export
%foreign (stdlib "difference")
difference : L5Tree -> L5Tree -> L5Tree
  
public export
%foreign (stdlib "offset")
offset : L5Tree -> TFloat -> L5Tree
  
public export
%foreign (stdlib "clearance")
clearance : L5Tree -> L5Tree -> TFloat -> L5Tree
  
public export
%foreign (stdlib "shell")
shell : L5Tree -> TFloat -> L5Tree
  
public export
%foreign (stdlib "blend_expt")
blendExpt : L5Tree -> L5Tree -> TFloat -> L5Tree
  
public export
%foreign (stdlib "blend_expt_unit")
blendExptUnit : L5Tree -> L5Tree -> TFloat -> L5Tree
  
public export
%foreign (stdlib "blend_rough")
blendRough : L5Tree -> L5Tree -> TFloat -> L5Tree
  
public export
blend : L5Tree -> L5Tree -> TFloat -> L5Tree
blend = blendExptUnit
  
public export
%foreign (stdlib "blend_difference")
blendDifference : L5Tree -> L5Tree -> TFloat -> TFloat -> L5Tree
  
public export
%foreign (stdlib "morph")
morph : L5Tree -> L5Tree -> TFloat -> L5Tree
  
public export
%foreign (stdlib "loft")
loft : L5Tree -> L5Tree -> TFloat -> TFloat -> L5Tree
  
public export
%foreign (stdlib "loft_between")
loftDifference : L5Tree -> L5Tree -> TVec3 -> TVec3 -> L5Tree

  
-- shapes
-- 2d
public export
%foreign (stdlib "circle")
circle : L5Tree -> TVec2 -> L5Tree

public export
%foreign (stdlib "ring")
ring : TFloat -> TFloat -> TVec2 -> L5Tree

public export
%foreign (stdlib "polygon")
polygon : L5Tree -> Int -> TVec2 -> L5Tree

public export
%foreign (stdlib "rectangle")
rectangle : TVec2 -> TVec2 -> L5Tree

public export
%foreign (stdlib "rounded_rectangle")
roundedRectangle : TVec2 -> TVec2 -> TFloat -> L5Tree

public export
%foreign (stdlib "rectangle_exact")
rectangleExact : TVec2 -> TVec2 -> L5Tree

public export
%foreign (stdlib "rectangle_centered_exact")
rectangleCenteredExact : TVec2 -> TVec2 -> L5Tree

public export
%foreign (stdlib "triangle")
triangle : TVec2 -> TVec2 -> TVec2 -> L5Tree

-- 3d
public export
%foreign (stdlib "box_mitered")
boxMitered : TVec3 -> TVec3 -> L5Tree

public export
cube : TVec3 -> TVec3 -> L5Tree
cube = boxMitered

public export
box : TVec3 -> TVec3 -> L5Tree
box = boxMitered

public export
%foreign (stdlib "box_mitered_centered")
boxMiteredCentered : TVec3 -> TVec3 -> L5Tree

public export
cubeCentered : TVec3 -> TVec3 -> L5Tree
cubeCentered = boxMiteredCentered

public export
boxCentered : TVec3 -> TVec3 -> L5Tree
boxCentered = boxMiteredCentered

public export
%foreign (stdlib "box_exact_centered")
boxExactCentered : TVec3 -> TVec3 -> L5Tree

public export
%foreign (stdlib "box_exact")
boxExact : TVec3 -> TVec3 -> L5Tree

public export
%foreign (stdlib "rounded_box")
roundedBox : TVec3 -> TVec3 -> TFloat -> L5Tree

public export
%foreign (stdlib "sphere")
sphere : TFloat -> TVec3 -> L5Tree

public export
%foreign (stdlib "half_space")
halfSpace : TVec3 -> TVec3 -> L5Tree

public export
%foreign (stdlib "cylinder_z")
cylinderZ : TFloat -> TFloat -> TVec3 -> L5Tree

public export
cylinder : TFloat -> TFloat -> TVec3 -> L5Tree
cylinder = cylinderZ

public export
%foreign (stdlib "cone_ang_z")
coneAngZ : TFloat -> TFloat -> TVec3 -> L5Tree

public export
coneAng : TFloat -> TFloat -> TVec3 -> L5Tree
coneAng = coneAngZ

public export
%foreign (stdlib "cone_z")
coneZ : TFloat -> TFloat -> TVec3 -> L5Tree

public export
cone : TFloat -> TFloat -> TVec3 -> L5Tree
cone = coneZ

public export
%foreign (stdlib "pyramid_z")
pyramidZ : TVec2 -> TVec2 -> TFloat -> TFloat -> L5Tree

public export
%foreign (stdlib "torus_z")
torusZ : TFloat -> TFloat -> TVec3 -> L5Tree

public export
torus : TFloat -> TFloat -> TVec3 -> L5Tree
torus = torusZ

public export
%foreign (stdlib "gyroid")
gyroid : TVec3 -> TFloat -> L5Tree

public export
%foreign (stdlib "emptiness")
emptiness : L5Tree
  
-- arrays
public export
%foreign (stdlib "array_x")
arrayX : L5Tree -> Int -> TFloat -> L5Tree

public export
%foreign (stdlib "array_xy")
arrayXY : L5Tree -> Int -> Int -> TVec2 -> L5Tree

public export
%foreign (stdlib "array_xyz")
arrayXYZ : L5Tree -> Int -> Int -> Int -> TVec3 -> L5Tree

public export
%foreign (stdlib "array_polar_z")
arrayPolarZ : L5Tree -> Int -> TVec2 -> L5Tree

public export
arrayPolar : L5Tree -> Int -> TVec2 -> L5Tree
arrayPolar = arrayPolarZ

public export
%foreign (stdlib "extrude_z")
extrudeZ : L5Tree -> TFloat -> TFloat -> L5Tree
  

-- transforms
public export
%foreign (stdlib "move")
move :
  L5Tree ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "reflect_x")
reflectX :
  L5Tree ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "reflect_y")
reflectY :
  L5Tree ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "reflect_z")
reflectZ :
  L5Tree ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "reflect_xy")
reflectXY :
  L5Tree ->
  L5Tree
  
public export
%foreign (stdlib "reflect_yz")
reflectYZ :
  L5Tree ->
  L5Tree
  
public export
%foreign (stdlib "reflect_xz")
reflectXZ :
  L5Tree ->
  L5Tree
  
public export
%foreign (stdlib "symmetric_x")
symmetricX :
  L5Tree ->
  L5Tree
  
public export
%foreign (stdlib "symmetric_y")
symmetricY :
  L5Tree ->
  L5Tree
  
public export
%foreign (stdlib "symmetric_z")
symmetricZ :
  L5Tree ->
  L5Tree
  
public export
%foreign (stdlib "scale_x")
scaleX :
  L5Tree ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "scale_y")
scaleY :
  L5Tree ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "scale_z")
scaleZ :
  L5Tree ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "scale_xyz")
scaleXYZ :
  L5Tree ->
  TVec3 ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "rotate_x")
rotateX :
  L5Tree ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "rotate_y")
rotateY :
  L5Tree ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "rotate_z")
rotateZ :
  L5Tree ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
rotate :
  L5Tree ->
  TFloat ->
  TVec3 ->
  L5Tree
rotate = rotateZ
  
public export
%foreign (stdlib "taper_x_y")
taperXY :
  L5Tree ->
  TVec2 ->
  TFloat ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "taper_xy_z")
taperXYZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "shear_x_y")
shearXY :
  L5Tree ->
  TVec2 ->
  TFloat ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel")
repel :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel_x")
repelX :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel_y")
repelY :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel_z")
repelZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel_xy")
repelXY :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel_yz")
repelYZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "repel_xz")
repelXZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract")
attract :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract_x")
attractX :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract_y")
attractY :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract_z")
attractZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract_xy")
attractXY :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract_yz")
attractYZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "attract_xz")
attractXZ :
  L5Tree ->
  TVec3 ->
  TFloat ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "revolve_y")
revolveY :
  L5Tree ->
  TFloat ->
  L5Tree
  
public export
%foreign (stdlib "twirl_x")
twirlX :
  L5Tree ->
  TFloat ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "twirl_axis_x")
twirlAxisX :
  L5Tree ->
  TFloat ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "twirl_y")
twirlY :
  L5Tree ->
  TFloat ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "twirl_axis_y")
twirlAxisY :
  L5Tree ->
  TFloat ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "twirl_z")
twirlZ :
  L5Tree ->
  TFloat ->
  TFloat ->
  TVec3 ->
  L5Tree
  
public export
%foreign (stdlib "twirl_axis_z")
twirlAxisZ :
  L5Tree ->
  TFloat ->
  TFloat ->
  TVec3 ->
  L5Tree
  
  
-- text
public export
%foreign (stdlib "text")
text : String -> TVec2 -> L5Tree
