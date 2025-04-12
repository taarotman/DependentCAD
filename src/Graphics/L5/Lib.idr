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
  
