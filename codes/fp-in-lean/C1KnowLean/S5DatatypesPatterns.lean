import C1KnowLean.S4Structures


-- inductive datatypes: recurvice sum types
-- sum types: disjoint union of types
-- product types: tuples, records, structs
-- recursive types: trees, lists, etc.

inductive MyBool where
  | true : MyBool
  | false : MyBool

#eval MyBool.true
#eval MyBool.false

inductive MyNat where
  | zero : MyNat
  | succ (n: MyNat): MyNat


--------------------------------------------------------------------------------
-- Pattern matching
--------------------------------------------------------------------------------
def isZero(n: MyNat): MyBool :=
  match n with
  | MyNat.zero => MyBool.true
  | MyNat.succ _ => MyBool.false

#eval isZero MyNat.zero -- MyBool.true
#eval isZero (MyNat.succ MyNat.zero) -- MyBool.false


def pred(n: MyNat): MyNat :=
  match n with
  | MyNat.zero => MyNat.zero
  | MyNat.succ m => m
#eval pred MyNat.zero
#eval pred (MyNat.succ MyNat.zero)
#eval pred (MyNat.succ (MyNat.succ MyNat.zero))


def depth(p: Point3D): Float :=
  match p with
  | { x := _, y := _, z := d } => d
#eval depth { x := 1.0, y := 2.0, z := 3.0 } -- 3.000000

--------------------------------------------------------------------------------
-- recursive functions
--------------------------------------------------------------------------------
