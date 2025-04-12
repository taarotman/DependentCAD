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
