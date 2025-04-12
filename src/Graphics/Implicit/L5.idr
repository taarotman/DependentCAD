module Graphics.Implicit.L5

import Graphics.Implicit.Shape
import Graphics.L5.Lib
import Data.String
-- import System.FFI
import System.File.ReadWrite

public export
opcode1 : UnaryOp -> String
opcode1 Square   = "square"
opcode1 Sqrt     = "sqrt"
opcode1 Neg      = "neg"
opcode1 Sin      = "sin"
opcode1 Cos      = "cos"
opcode1 Tan      = "tan"
opcode1 Asin     = "asin"
opcode1 Acos     = "acos"
opcode1 Atan     = "atan"
opcode1 Exp      = "exp"
opcode1 Abs      = "abs"
opcode1 Log      = "log"
opcode1 Recip    = "recip"
opcode1 ConstVar = "const_var"

public export
opcode2 : BinaryOp -> String
opcode2 Add     = "add"
opcode2 Mul     = "mul"
opcode2 Min     = "min"
opcode2 Max     = "max"
opcode2 Sub     = "sub"
opcode2 Div     = "div"
opcode2 Atan2   = "atan2"
opcode2 Pow     = "pow"
opcode2 NthRoot = "nth_root"
opcode2 Mod     = "mod"
opcode2 NanFill = "nanfill"
opcode2 Compare = "compare"

public export
evalShape : Shape -> L5Tree
evalShape (Cn i)       = l5TreeConst $ fromInt i
evalShape X            = l5TreeX
evalShape Y            = l5TreeY
evalShape Z            = l5TreeZ
evalShape (Un o s)     = l5TreeUnary (l5OpcodeEnum $ opcode1 o) $ evalShape s
evalShape (Bi o s1 s2) = 
  l5TreeBinary (l5OpcodeEnum $ opcode2 o) (evalShape s1) (evalShape s2)

-- pmap : Bifunctor f => (a -> b) -> f a a -> f b b
-- pmap f = bimap f f

-- public export
-- evalBounds : Bounds -> L5Region3
-- evalBounds (MkB min max) = 
--   let
--     -- x = ("X", pmap fromInt (min.x, min.x))
--     -- y = ("Y", pmap fromInt (min.y, min.y))
--     -- z = ("Z", pmap fromInt (min.z, min.z))
--     xmin = fromInt min.x
--     xmax = fromInt max.x
--     ymin = fromInt min.y
--     ymax = fromInt max.y
--     zmin = fromInt min.z
--     zmax = fromInt max.z
--   in 
--   toRegion3 xmin xmax 
--             ymin ymax 
--             zmin zmax

-- meshRender : HasIO io =>
--   L5Tree ->
--   Bounds ->
--   Int ->
--   io L5Mesh
-- meshRender tree bounds res = 
--   let
--     region = evalBounds bounds
--   in
--   do primIO $ l5TreeRenderMeshSt tree region (fromInt res)

-- saveSTL : HasIO io =>
--   L5Tree -> 
--   Bounds -> 
--   Int -> 
--   String -> 
--   io Bool'
--   -- io String
-- saveSTL tree bounds@(MkB min max) res filename = 
--   let
--     region = evalBounds bounds

--     -- xmin = fromInt min.x
--     -- xmax = fromInt max.x
--     -- ymin = fromInt min.y
--     -- ymax = fromInt max.y
--     -- zmin = fromInt min.z
--     -- zmax = fromInt max.z
--   in 
--   do -- f <- pure filename
--      -- putStrLn filename
--      -- region <- evalBounds bounds
--      --primIO $ printRegion3 region
--      l5TreeSaveMeshFix tree region (fromInt res) filename 
--      -- primIO $ l5TreeSaveMesh tree region (fromInt res) (stringFix filename)
--      -- l5TreeSaveMeshFixFull filename 
--      --                       tree 
--      --                       xmin xmax
--      --                       ymin ymax
--      --                       zmin zmax
--      --                       (fromInt res)
--      -- primIO $ l5TreeSaveMeshArgs filename tree region (fromInt res)



printShape : HasIO io =>
  Shape ->
  io String
printShape = primIO . l5TreePrint . evalShape
  
public export
printShapeScheme : HasIO io =>
  Shape ->
  io String
printShapeScheme shape =
  let
    scm : String -> String
    scm e = "(lambda-shape (x y z) " ++ e ++ ")"
  in
  scm <$> printShape shape

public export
printShapesScheme : HasIO io =>
  List Shape ->
  io String
printShapesScheme shapes = 
  do lShapes <- traverse printShapeScheme shapes
     pure $ unlines lShapes

public export
printScheme : HasIO io =>
  List Shape ->
  {default (MkB (MkV3 (-10) (-10) (-10)) (MkV3 10 10 10)) bounds : Bounds} ->
  {default 8 q : Int} ->
  {default 10 res : Int} ->
  io String
printScheme shapes {bounds} {q} {res} = 
  let
    pBounds : Bounds -> String
    pBounds b =  
      "(set-bounds! [" ++ show b.min.x ++ " " ++ 
                          show b.min.y ++ " " ++ 
                          show b.min.z ++ "] " ++
                   "[" ++ show b.max.x ++ " " ++  
                          show b.max.y ++ " " ++
                          show b.max.z ++ "])"

    pQ : Int -> String
    pQ i = "(set-quality! " ++ show i ++ ")"
    
    pRes : Int -> String
    pRes i = "(set-resolution! " ++ show i ++ ")"
  in
  do pShapes <- printShapesScheme shapes
     pure $ unlines $ [pBounds bounds, pQ q, pRes res, pShapes]

public export
exportShapesE : HasIO io =>
  List Shape ->
  String ->
  {default (MkB (MkV3 (-10) (-10) (-10)) (MkV3 10 10 10)) bounds : Bounds} ->
  {default 8 q : Int} ->
  {default 10 res : Int} ->
  io (Either FileError ())
exportShapesE shapes filename {bounds} {q} {res} = 
  do contents <- printScheme shapes {bounds=bounds} {q=q} {res=res}
     writeFile filename contents

public export
exportShapes : HasIO io =>
  List Shape ->
  String ->
  {default (MkB (MkV3 (-10) (-10) (-10)) (MkV3 10 10 10)) bounds : Bounds} ->
  {default 8 q : Int} ->
  {default 10 res : Int} ->
  io ()
exportShapes shapes filename {bounds} {q} {res} = 
  let
    iosuffix = filename ++ ".io"
  in
  do exp <- exportShapesE shapes iosuffix {bounds=bounds} {q=q} {res=res}
     case exp of
          (Left  x) => printLn x
          (Right _) => putStrLn $ "saved to " ++ iosuffix


-- renderShape : HasIO io => 
--   Shape -> 
--   Bounds -> 
--   {default 10 res : Int} -> 
--   io ()
-- renderShape shape bounds {res} = 
--   let
--     tree = evalShape shape
--   in
--   do mesh <- meshRender tree bounds res
--      putStrLn $ showMesh mesh
--      pure ()

-- saveShapeSTL : HasIO io => 
--   Shape -> 
--   Bounds -> 
--   {default 10 res : Int} -> 
--   String -> 
--   io ()
-- saveShapeSTL shape bounds {res} filename = 
--   let
--     tree = evalShape shape
--   in
--   do p <- primIO $ l5TreePrint tree
--      -- putStr "saving structure: "
--      -- printLn p
--      -- putStrLn $ "saveSTL: will be put in: " ++ filename
--      -- mesh <- meshRender tree bounds res
--      -- putStrLn $ showMesh mesh
--      save <- saveSTL tree bounds res filename
--      p <- primIO $ l5TreePrint tree
--      -- free tree
--      --putStrLn save
--      -- case save of
--      --      False => putStrLn "saveShapeSTL: success"
--      --      True => putStrLn "saveShapeSTL: fail"
--      --putStrLn "success!"
--      pure ()

  
  
  
-- treeTest : L5Tree
-- treeTest = 
--   let
--     -- x = l5TreeX
--     -- y = l5TreeY
    
--     -- x2 = l5TreeUnary (l5OpcodeEnum "square") x
--     -- y2 = l5TreeUnary (l5OpcodeEnum "square") y
  
--     -- s = l5TreeBinary (l5OpcodeEnum "add") x2 y2
  
--     -- one = l5TreeConst $ fromInt 1323
--     -- out = l5TreeBinary (l5OpcodeEnum "sub") s one
--     sphere : Int -> Shape
--     sphere r = (X * X) + (Y * Y) + (Z * Z) - Cn r
--     out = sphere 5
--   in 
--   evalShape out
  
-- test : IO String
-- test = primIO $ l5TreePrint treeTest 
  
test2 : String -> IO ()
test2 filename = 
  let
    sphere : Int -> Shape
    sphere r = (X * X) + (Y * Y) + (Z * Z) - Cn r
    out = sphere 3
    out2 = sphere 5
    -- out = (X*(Cn 1))+(X-(Cn 1))/(Y-(Cn 2))+Y-Z+X*Z
  
    -- b : Bounds
    -- b = MkB (MkV3 (-5) (-5) (-5)) (MkV3 5 5 5)
  in 
  do -- p <- printScheme [out, out2]
     -- printLn p
     exportShapes [out,out2] filename
     -- saveShapeSTL out b filename

main : IO ()
-- main = putStrLn "testl"
main = 
  -- let
  --   -- x : IO L5Tree
  --   -- x = l5Tree 23.3
  --   x : IO String
  --   x = test
  -- in
  do 
  -- putStrLn ("L5t")
  --putStrLn (test 3) 
  -- a <- x
  -- putStrLn a
  --printLn $ toDouble $ fromDouble 3.33
  --frees a  
  -- printLn $ l5OpcodeEnum "square"
  --a <- x 
  --?aaa 
  putStr "filename: "
  b <- getLine
  -- putStrLn $ "filename for saving: " ++ b
  test2 b
  -- bf <- primIO $ stringFix b
  -- putStrLn bf
  pure ()
