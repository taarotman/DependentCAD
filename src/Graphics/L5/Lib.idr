module Graphics.L5.Lib

import System.FFI
  

public export
ffi : String -> String -> String
ffi fn lib = "C:" ++ fn ++ "," ++ lib


utils : String -> String
utils fn = ffi fn "utils.so"

  
public export
srclib : String -> String
srclib fn = ffi fn "libfive.so"
  
public export
Float : Type
Float = Double
  
public export
Bool' : Type
Bool' = AnyPtr

-- public export
-- intToFloat : Int -> Float
-- intToFloat = believe_me 

-- doubleToFloat : Double -> Float -- DOES NOT WORK
-- doubleToFloat = believe_me -- DONT BELIEVE IT


--
-- Struct definitions
--
public export
L5Interval : Type
public export
L5Region2 : Type
public export
L5Region3 : Type
public export
L5Vec2 : Type
public export
L5Vec3 : Type
public export
L5Vec4 : Type
public export
L5Tri : Type
public export
L5Contour : Type
public export
L5Contours : Type
public export
L5Contour3 : Type
public export
L5Contours3 : Type
public export
L5Mesh : Type
public export
L5MeshCoords : Type
public export
L5Pixels : Type
  
L5Interval = 
  Struct "libfive_interval" 
    [ ("lower", Float)
    , ("upper", Float)
    ]
  
L5Region2 =
  Struct "libfive_region2" 
    [ ("X", L5Interval) 
    , ("Y", L5Interval)
    ]

L5Region3 =
  Struct "libfive_region3" 
    [ ("X", L5Interval) 
    , ("Y", L5Interval) 
    , ("Z", L5Interval)
    ]

L5Vec2 =
  Struct "libfive_vec2" 
    [ ("x", Float) 
    , ("y", Float)
    ]

L5Vec3 =
  Struct "libfive_vec3" 
    [ ("x", Float) 
    , ("y", Float) 
    , ("z", Float)
    ]

L5Vec4 =
  Struct "libfive_vec4" 
    [ ("x", Float) 
    , ("y", Float) 
    , ("z", Float) 
    , ("w", Float)
    ]

L5Tri = 
  Struct "libfive_tri" 
    [ ("a", Int) 
    , ("b", Int) 
    , ("c", Int)
    ]

L5Contour = 
  Struct "libfive_contour" 
    [ ("pts", Ptr L5Vec2) 
    , ("count", Int)
    ]

L5Contours = 
  Struct "libfive_contours" 
    [ ("cs", Ptr L5Contour) 
    , ("count", Int)
    ]

L5Contour3 = 
  Struct "libfive_contour3" 
    [ ("pts", Ptr L5Vec3) 
    , ("count", Int)
    ]

L5Contours3 = 
  Struct "libfive_contours3" 
    [ ("cs", Ptr L5Contour3) 
    , ("count", Int)
    ]

L5Mesh = 
  Struct "libfive_mesh" 
    [ ("verts", Ptr L5Vec3) 
    , ("tris", Ptr L5Tri)
    , ("tri_count", Int)
    , ("vert_count", Int)
    ]
  
L5MeshCoords = 
  Struct "libfive_mesh_coords" 
    [ ("verts", Ptr L5Vec3) 
    , ("vert_count", Int)
    , ("coord_indices", Ptr Int)
    , ("coord_index_count", Int)
    ]
  
L5Pixels = 
  Struct "libfive_pixels" 
    [ ("pixels", Ptr Bool') 
    , ("width", Int)
    , ("height", Int)
    ]


-- 
-- Structs free functions
--
public export
%foreign (srclib "libfive_contours_delete")
l5ContoursDelete : Ptr L5Contours -> PrimIO ()

public export
%foreign (srclib "libfive_contours3_delete")
l5Contours3Delete : Ptr L5Contours3 -> PrimIO ()

public export
%foreign (srclib "libfive_mesh_delete")
l5MeshDelete : Ptr L5Mesh -> PrimIO ()

public export
%foreign (srclib "libfive_mesh_coords_delete")
l5MeshCoordsDelete : Ptr L5MeshCoords -> PrimIO ()

public export
%foreign (srclib "libfive_pixels_delete")
l5PixelsDelete : Ptr L5Pixels -> PrimIO ()

public export
%foreign (srclib "libfive_opcode_enum")
l5OpcodeEnum : String -> Int

public export
%foreign (srclib "libfive_opcode_args")
l5OpcodeArgs : Int -> Int

  
--
-- libfive_vars
--
public export
L5Vars : Type
L5Vars = 
  Struct "libfive_vars" 
    [ ("vars", AnyPtr) 
    , ("values", Ptr Float)
    , ("size", Int)
    ]

public export
%foreign (srclib "libfive_vars_delete")
l5VarsDelete : Ptr L5Vars -> PrimIO ()


--
-- libfive_tree
--
public export
L5Tree : Type
L5Tree = AnyPtr

public export
%foreign (srclib "libfive_tree_x")
l5TreeX : L5Tree  
public export
%foreign (srclib "libfive_tree_y")
l5TreeY : L5Tree  
public export
%foreign (srclib "libfive_tree_z")
l5TreeZ : L5Tree  

public export
%foreign (srclib "libfive_tree_var")
l5TreeVar : L5Tree
public export
%foreign (srclib "libfive_tree_is_var")
l5TreeIsVar : L5Tree -> Bool'

public export
%foreign (srclib "libfive_tree_const")
l5TreeConst : Float -> L5Tree
public export
%foreign (srclib "libfive_tree_get_const")
l5TreeGetConst : L5Tree -> Ptr Bool' -> PrimIO Float
  
public export
%foreign (srclib "libfive_tree_nullary")
l5TreeNullary : Int -> L5Tree
public export
%foreign (srclib "libfive_tree_unary")
l5TreeUnary : Int -> L5Tree -> L5Tree
public export
%foreign (srclib "libfive_tree_binary")
l5TreeBinary : Int -> L5Tree -> L5Tree -> L5Tree
 
public export
%foreign (srclib "libfive_tree_id")
l5TreeId : L5Tree -> AnyPtr

public export
%foreign (srclib "libfive_tree_eval_r")
l5TreeEvalR : L5Tree -> L5Region3 -> L5Interval
public export
%foreign (srclib "libfive_tree_eval_d")
l5TreeEvalD : L5Tree -> L5Vec3 -> L5Vec3
  
public export
%foreign (srclib "libfive_tree_delete")
l5TreeDelete : L5Tree -> PrimIO ()

public export
%foreign (srclib "libfive_tree_save")
l5TreeSave : L5Tree -> String -> PrimIO Bool'

public export
%foreign (srclib "libfive_tree_load")
l5TreeLoad : String -> PrimIO L5Tree
  
public export
%foreign (srclib "libfive_tree_remap")
l5TreeRemap : L5Tree -> L5Tree -> L5Tree -> L5Tree -> L5Tree

public export
%foreign (srclib "libfive_tree_optimized")
l5TreeOptimized : L5Tree -> PrimIO L5Tree

public export
%foreign (srclib "libfive_tree_print")
l5TreePrint : L5Tree -> PrimIO String
public export
%foreign (srclib "libfive_free_str")
l5FreeStr : String -> PrimIO ()


-- Rendering
public export
%foreign (srclib "libfive_tree_render_slice")
l5TreeRenderSlice : 
  L5Tree -> 
  L5Region2 -> 
  Float -> 
  Float -> 
  PrimIO (Ptr L5Contours)

public export
%foreign (srclib "libfive_tree_render_slice3")
l5TreeRenderSlice3 : 
  L5Tree -> 
  L5Region2 -> 
  Float -> 
  Float -> 
  PrimIO (L5Contours)

public export
%foreign (srclib "libfive_tree_render_mesh")
l5TreeRenderMesh : 
  L5Tree -> 
  L5Region3 -> 
  Float -> 
  PrimIO (L5Mesh)
  
public export
%foreign (srclib "libfive_tree_render_mesh_st")
l5TreeRenderMeshSt : 
  L5Tree -> 
  L5Region3 -> 
  Float -> 
  PrimIO (L5Mesh)

public export
%foreign (srclib "libfive_tree_render_mesh_coords")
l5TreeRenderMeshCoords : 
  L5Tree -> 
  L5Region3 -> 
  Float -> 
  PrimIO (L5MeshCoords)
  
public export
%foreign (srclib "libfive_tree_save_mesh")
l5TreeSaveMesh : 
  L5Tree -> 
  L5Region3 -> 
  Float ->
  Ptr String ->
  PrimIO Bool'
  
public export
%foreign (srclib "libfive_tree_save_meshes")
l5TreeSaveMeshes : 
  Ptr L5Tree -> 
  L5Region3 -> 
  Float -> 
  Float -> 
  String ->
  PrimIO Bool'

public export
%foreign (srclib "libfive_tree_render_pixels")
l5TreeRenderPixels : 
  L5Tree -> 
  L5Region2 -> 
  Float -> 
  Float -> 
  PrimIO (Ptr L5Pixels)
  

--
-- libfive_evaluator
--
public export
L5Evaluator : Type
L5Evaluator = AnyPtr
  
public export
%foreign (srclib "libfive_evaluator_save_mesh")
l5EvaluatorSaveMesh : 
  L5Evaluator -> 
  L5Region3 -> 
  String ->
  PrimIO Bool'

public export
%foreign (srclib "libfive_tree_evaluator")
l5TreeEvaluator : L5Tree -> L5Vars -> L5Evaluator

public export
%foreign (srclib "libfive_evaluator_update_vars")
l5EvaluatorUpdateVars : 
  L5Evaluator ->  
  L5Vars -> 
  PrimIO Bool'

public export
%foreign (srclib "libfive_evaluator_delete")
l5EvaluatorDelete : 
  L5Evaluator ->  
  PrimIO ()

  
  
public export
%foreign (utils "from_int")
fromInt : Int -> Float
  
-- public export
-- %foreign (utils "to_int")
-- toInt : Float -> Int
  
-- showVec3 : L5Vec3 -> String
-- showVec3 v = 
--   let
--     x : Int = toInt $ getField v "x"
--     y : Int = toInt $ getField v "y"
--     z : Int = toInt $ getField v "z"
--   in
--   show (x,y,z)

-- showTri : L5Tri -> String
-- showTri t = 
--   let
--     a : Int = getField t "a"
--     b : Int = getField t "b"
--     c : Int = getField t "c"
--   in
--   show (a,b,c)

-- public export
-- showMesh : L5Mesh -> String
-- showMesh m = 
--   let
--     -- vc3 : L5Vec3 = getField m "verts"
--     -- tri : L5Tri = getField m "tris"
--     trc : Int = getField m "tri_count"
--     vrc : Int = getField m "vert_count"
--   in
--   show (trc,vrc)

-- public export
-- %foreign (utils "string_fix")
-- stringFix : String -> Ptr String

-- %foreign (utils "string_test")
-- stringTest : String -> String -> String

-- public export
-- %foreign (utils "libfive_tree_save_mesh_args")
-- l5TreeSaveMeshArgs : 
--  String ->
--  L5Tree -> 
--  L5Region3 -> 
--  Float ->
--  PrimIO String
  
-- public export
-- %foreign (utils "print_region3")
-- printRegion3 : L5Region3 -> PrimIO ()

-- public export
-- %foreign (utils "to_region3")
-- toRegion3 :
--   Float -> Float ->
--   Float -> Float ->
--   Float -> Float ->
--   L5Region3

-- %foreign (utils "libfive_tree_save_mesh_fix")
-- l5TreeSaveMeshFix' : 
--  L5Tree -> 
--  L5Region3 -> 
--  Float ->
--  Ptr String ->
--  ( L5Tree ->
--    PrimIO String
--  ) ->
--  ( L5Tree -> 
--    L5Region3 -> 
--    Float -> 
--    Ptr String ->
--    PrimIO Bool'
--  ) ->
--  PrimIO Bool'
 
-- public export
-- l5TreeSaveMeshFix : HasIO io =>
--  L5Tree -> 
--  L5Region3 -> 
--  Float ->
--  String ->
--  io Bool'
-- l5TreeSaveMeshFix t r q s = 
--   let
--     sf = stringFix s
--   in
--   do -- putStrLn $ "do: " ++ s 
--      primIO $ l5TreeSaveMeshFix' t r q sf l5TreePrint l5TreeSaveMesh

-- %foreign (utils "libfive_tree_save_mesh_fix_full")
-- l5TreeSaveMeshFixFull' :
--   Ptr String ->
--   L5Tree ->
--   Float -> Float ->
--   Float -> Float ->
--   Float -> Float ->
--   Float ->
--   ( L5Tree -> 
--     L5Region3 -> 
--     Float -> 
--     Ptr String ->
--     PrimIO Bool'
--   ) ->
--   PrimIO Bool'

-- saveMesh : HasIO io => L5Tree -> L5Region3 -> Float -> String -> io Bool'
-- saveMesh x y dbl str = primIO $ l5TreeSaveMesh x y dbl str

-- public export
-- l5TreeSaveMeshFixFull : HasIO io =>
--  String ->
--  L5Tree -> 
--  Float -> Float ->
--  Float -> Float ->
--  Float -> Float ->
--  Float ->
--  io Bool'
-- l5TreeSaveMeshFixFull s t x1 x2 y1 y2 z1 z2 q =
-- -- l5TreeSaveMeshFix s t r q = 
--   -- let
--   --   -- save : HasIO io => L5Tree -> L5Region3 -> Float -> String -> io Bool'
--   --   -- save x y dbl str = primIO $ l5TreeSaveMesh x y dbl str
--   --   sm = saveMesh
--   -- in
--   do -- putStrLn $ "do: " ++ s 
--      -- sm <- (\t, r, q, f => saveMesh t r q f)
--      primIO $ l5TreeSaveMeshFixFull' (stringFix s) t x1 x2 y1 y2 z1 z2 q l5TreeSaveMesh
  
-- %foreign (utils "from_double")
-- fromDouble : Double -> Float

-- %foreign (utils "float_test")
-- floatTest : Double -> Double

-- %foreign (utils "fdouble_test")
-- doubleTest : Double -> Double

-- %foreign (utils "fint_test")
-- intTest : Int -> Int

-- %foreign (utils "to_double")
-- toDouble : Float -> Double

-- ptrBool' : Bool' -> Ptr Bool'
-- ptrBool' x = ?aaa

--ptrBool' b = Ptr b

treeTest : PrimIO String
treeTest = 
  let
    x = l5TreeX
    y = l5TreeY
    
    x2 = l5TreeUnary (l5OpcodeEnum "square") x
    y2 = l5TreeUnary (l5OpcodeEnum "square") y
  
    s = l5TreeBinary (l5OpcodeEnum "add") x2 y2
  
    one = l5TreeConst $ fromInt 1323
    out = l5TreeBinary (l5OpcodeEnum "sub") s one
  in 
  l5TreePrint $ out
  
  
test : HasIO io => io String
test = primIO $ treeTest 
  
-- frees : HasIO io => String -> io ()
-- frees = primIO . l5FreeStr

--  
main : IO ()
main = printLn "Hello"
-- main = 
--   let
--     -- x : IO L5Tree
--     -- x = l5Tree 23.3
--     x : IO String
--     x = test
--   in
--   do 
--   printLn (l5OpcodeEnum "sub") 
--   --putStrLn (test 3) 
--   a <- x
--   putStrLn a
--   -- xx <- getLine
--   -- b <- primIO $ stringFix xx
--   -- b <- primIO $ stringFix xx
--   putStrLn $ stringTest "abc" "def"
--   --printLn $ toDouble $ fromDouble 3.33
--   -- printLn $ doubleTest 2324.25
--   --frees a
--   --a <- x 
--   --?aaa 
--   pure ()
  
--main : IO ()
--main = putStrLn "Hello"
  
