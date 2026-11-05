inductive Pos : Type where
  | one : Pos
  | succ : Pos -> Pos

-- ERROR:
-- failed to synthesize instance of type class
--   OfNat Pos 7
-- numerals are polymorphic in Lean, but the numeral `7` cannot be used in a context where the expected type is
--   Pos
-- due to the absence of the instance above
-- def seven : Pos := 7

def seven : Pos := Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))

-- ERROR:
-- failed to synthesize instance of type class
--   HAdd Pos Pos ?m.3
-- def fourteen : Pos := seven + seven

-- ERROR:
-- failed to synthesize instance of type class
--   HMul Pos Pos ?m.3
-- def fortyNine : Pos := seven * seven

--------------------------------------------------------------------------------
-- classes and instances
--------------------------------------------------------------------------------
class Plus (α : Type) where
  plus : α -> α -> α

-- overload for a particular type
instance : Plus Nat where
  plus := Nat.add

#eval Plus.plus 5 3 -- 8

open Plus (plus) -- make plus visible
#eval plus 5 3 -- 8

def Pos.plus: Pos -> Pos -> Pos
| Pos.one, k => Pos.succ k
| Pos.succ n, k => Pos.succ (n.plus k)

instance : Plus Pos where
  plus := Pos.plus

def fourteen : Pos := plus seven seven

instance : Plus Float where
  plus := Float.add
#eval plus 5.2 917.25861 -- 922.458610

--------------------------------------------------------------------------------
-- overloaded addition
--------------------------------------------------------------------------------
-- HAdd: heterogeneous addition
-- Add
instance : Add Pos where
  add := Pos.plus
def fourtenV2 : Pos := seven + seven

--------------------------------------------------------------------------------
-- conversion to strings
--------------------------------------------------------------------------------
-- ToString
def posToString (atTop : Bool)(p : Pos) : String :=
  let paren s := if atTop then s else "(" ++ s ++ ")"
  match p with
  | Pos.one => "Pos.one"
  | Pos.succ n => paren s!"Pos.succ {posToString false n}"

instance : ToString Pos where
  toString := posToString true

#eval s!"There are {seven}" -- "There are Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))"

def Pos.toNat : Pos -> Nat
  | Pos.one => 1
  | Pos.succ n => n.toNat + 1

-- does it mean override???
instance : ToString Pos where
  toString x := toString (x.toNat)

#eval s!"Thre are {seven}" -- "Thre are 7"

--------------------------------------------------------------------------------
-- overloaded multiplication
--------------------------------------------------------------------------------
-- Mul
def Pos.mul : Pos -> Pos -> Pos
  | Pos.one, k => k
  | Pos.succ n, k => n.mul k + k

instance : Mul Pos where
  mul := Pos.mul

#eval [seven * Pos.one, seven * seven, Pos.succ Pos.one * seven] -- [7, 49, 14]

--------------------------------------------------------------------------------
-- literal numbers
--------------------------------------------------------------------------------
-- Zero, One, OfNat
instance : One Pos where
  one := Pos.one
#eval (1 : Pos) -- 1

instance : OfNat Pos (n + 1) where -- note: n+1
  ofNat :=
    let rec natPlusOne : Nat -> Pos
      | 0 => Pos.one
      | k + 1 => Pos.succ (natPlusOne k)
    natPlusOne n

def eight : Pos := 8
#eval eight -- 8
-- ERROR:
-- failed to synthesize instance of type class
--   OfNat Pos 0
-- numerals are polymorphic in Lean, but the numeral `0` cannot be used in a context where the expected type is
--   Pos
-- due to the absence of the instance above
-- def zero : Pos := 0


--------------------------------------------------------------------------------
-- exercises
--------------------------------------------------------------------------------
