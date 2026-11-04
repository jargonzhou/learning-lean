import C1KnowLean.S4Structures


-- inductive datatypes: recurvice sum types
-- sum types: disjoint union of types
-- product types: tuples, records, structs
-- recursive types: trees, lists, etc.

inductive MyBool where
  | true : MyBool
  | false : MyBool

def myNot(b: MyBool): MyBool :=
  match b with
  | MyBool.true => MyBool.false
  | MyBool.false => MyBool.true

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

def even(n: MyNat): MyBool :=
  match n with
  | MyNat.zero => MyBool.true
  | MyNat.succ m => myNot (even m)

#eval even MyNat.zero -- MyBool.true
#eval even (MyNat.succ MyNat.zero) -- MyBool.false
#eval even (MyNat.succ (MyNat.succ MyNat.zero)) -- MyBool.true

def evenLoops(n : MyNat): MyBool :=
  match n with
  | MyNat.zero => MyBool.true
  | MyNat.succ m => myNot (evenLoops m)

#eval evenLoops MyNat.zero -- MyBool.true
#eval evenLoops (MyNat.succ MyNat.zero) -- MyBool.false
#eval evenLoops (MyNat.succ (MyNat.succ MyNat.zero)) -- MyBool.true

def plus(m: MyNat)(n: MyNat): MyNat :=
  match m with
  | MyNat.zero => n
  | MyNat.succ k => MyNat.succ (plus k n)

def three: MyNat := MyNat.succ (MyNat.succ (MyNat.succ MyNat.zero))
def two: MyNat := MyNat.succ (MyNat.succ MyNat.zero)

#eval plus three two -- MyNat.succ (MyNat.succ (MyNat.succ (MyNat.succ (MyNat.succ MyNat.zero))))

def times(m: MyNat)(n: MyNat): MyNat :=
  match m with
  | MyNat.zero => MyNat.zero
  | MyNat.succ k => plus n (times k n)

#eval times three two -- MyNat.succ (MyNat.succ (MyNat.succ (MyNat.succ (MyNat.succ (MyNat.succ (MyNat.zero))))))

def divide(m: MyNat)(n: MyNat): MyNat :=
  match m with
  | MyNat.zero => MyNat.zero
  | MyNat.succ k =>
    match n with
    | MyNat.zero => MyNat.zero
    | MyNat.succ l =>
        match even m with
        | MyBool.true => MyNat.succ (divide k l)
        | MyBool.false => divide k l
#eval divide three two -- MyNat.succ (MyNat.zero)
