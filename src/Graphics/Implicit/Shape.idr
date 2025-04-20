module Graphics.Implicit.Shape
  
%default total

public export
data UnaryOp -- based on libfive's opcode
  = Square
  | Sqrt
  | Neg
  | Sin
  | Cos
  | Tan
  | Asin
  | Acos
  | Atan
  | Exp
  | Abs
  | Log
  | Recip
  | ConstVar

public export
data BinaryOp -- based on libfive's opcode
  = Add 
  | Mul
  | Min
  | Max
  | Sub
  | Div
  | Atan2
  | Pow
  | NthRoot
  | Mod
  | NanFill
  | Compare
  
public export
data Shape : Type where
  Cn : Num a => a -> Shape
  X : Shape
  Y : Shape
  Z : Shape
  Un : UnaryOp -> Shape -> Shape
  Bi : BinaryOp -> Shape -> Shape -> Shape
  

-- Primitive unary functions
public export
FnShape1 : Type
FnShape1 = Shape -> Shape

public export
square   : FnShape1
public export
sqrt     : FnShape1
public export
neg      : FnShape1
public export
sin      : FnShape1
public export
cos      : FnShape1
public export
tan      : FnShape1
public export
asin     : FnShape1
public export
acos     : FnShape1
public export
atan     : FnShape1
public export
exp      : FnShape1
public export
abs      : FnShape1
public export
log      : FnShape1
public export
recip    : FnShape1
public export
constVar : FnShape1

square   = Un Square
sqrt     = Un Sqrt
neg      = Un Neg
sin      = Un Sin
cos      = Un Cos
tan      = Un Tan
asin     = Un Asin
acos     = Un Acos
atan     = Un Atan
exp      = Un Exp
abs      = Un Abs
log      = Un Log
recip    = Un Recip
constVar = Un ConstVar


-- Primitive binary functions
public export
FnShape2 : Type
FnShape2 = Shape -> Shape -> Shape  

public export
(+)     : FnShape2
public export
(*)     : FnShape2
public export
min     : FnShape2
public export
max     : FnShape2
public export
(-)     : FnShape2
public export
(/)     : FnShape2
public export
atan2   : FnShape2
public export
pow     : FnShape2
public export
nthRoot : FnShape2
public export
mod     : FnShape2
public export
nanFill : FnShape2
public export
compare : FnShape2

(+)     a b = Bi Add     a b
(*)     a b = Bi Mul     a b
min     a b = Bi Min     a b
max     a b = Bi Max     a b
(-)     a b = Bi Sub     a b
(/)     a b = Bi Div     a b
atan2   a b = Bi Atan2   a b
pow     a b = Bi Pow     a b
nthRoot a b = Bi NthRoot a b
mod     a b = Bi Mod     a b
nanFill a b = Bi NanFill a b
compare a b = Bi Compare a b


public export
minL : List Shape -> Shape
minL = foldl min (Cn 0)

public export
maxL : List Shape -> Shape
maxL = foldl max (Cn 0)


public export
record Vec3 where
  constructor MkV3
  x,y,z : Int

public export
record Bounds where
  constructor MkB
  min, max : Vec3


sphere : Num a => a -> Shape
sphere r = (X * X) + (Y * Y) + (Z * Z) - Cn r

main : IO ()
main = putStrLn "test"
