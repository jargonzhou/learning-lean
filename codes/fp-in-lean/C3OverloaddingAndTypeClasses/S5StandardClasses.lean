import C3OverloaddingAndTypeClasses.S1PositiveNumbers
import C3OverloaddingAndTypeClasses.S4ArrayAndIndexing

--------------------------------------------------------------------------------
-- arithmetic
--------------------------------------------------------------------------------
/-
HAdd: +
HSub: -
HMul: *
HDiv: /
HMod: %
HPow: ^
Neg : -
-/


--------------------------------------------------------------------------------
-- bitwise operators
--------------------------------------------------------------------------------

/-
HAnd        : &&&
HOr         : |||
HXor        : ^^^
Complement  : ~~~
HShiftRight : >>>
HShiftLeft  : <<<
-/


--------------------------------------------------------------------------------
-- equality and ordering
--------------------------------------------------------------------------------

-- boolean equality: BEq.beq, ==
#eval "Octopus" ==  "Cuttlefish" -- false
#eval "Octopodes" ==  "Octo".append "podes" -- true
-- ERROR:
-- failed to synthesize instance of type class
--   BEq (Nat → Nat)
-- #eval (fun (x : Nat) => 1 + x) == (Nat.succ ·)

-- propositional equality
#check 2 < 4 -- 2 < 4 : Prop
#check if 2 < 4 then 1 else 2
-- Decidable
-- ERROR:
-- failed to synthesize instance of type class
--   Decidable ((fun x => 1 + x) = fun x => x.succ)
-- #check if (fun (x : Nat) => 1 + x) = (Nat.succ ·) then "yes" else "no"

/-
LT: < >
LE: ≤ ≥
-/
instance : LT Pos where
  lt x y := LT.lt x.toNat y.toNat
instance : LE Pos where
  le x y := LE.le x.toNat y.toNat

-- inferInstance: find an instance if it exists
instance {x : Pos} {y : Pos} : Decidable (x < y) :=
  (inferInstance : Decidable (x.toNat < y.toNat))
instance {x : Pos} {y : Pos} : Decidable (x ≤ y) :=
  (inferInstance : Decidable (x.toNat ≤ y.toNat))

-- Ordering
def Pos.comp : Pos -> Pos -> Ordering
  | Pos.one, Pos.one => Ordering.eq
  | Pos.one, Pos.succ _ => Ordering.lt
  | Pos.succ _, Pos.one => Ordering.gt
  | Pos.succ n, Pos.succ k => comp n k

instance : Ord Pos where
  compare := Pos.comp

#eval (3 : Pos) < (4 : Pos) -- true
#eval (3 : Pos) ≤ (4 : Pos) -- true
#eval (3 : Pos) > (4 : Pos) -- false
#eval (3 : Pos) ≥ (4 : Pos) -- false

--------------------------------------------------------------------------------
-- hashing
--------------------------------------------------------------------------------
-- Hashable
def hashPos : Pos -> UInt64
  | Pos.one => 0
  | Pos.succ n => mixHash 1 (hashPos n)
instance : Hashable Pos where
  hash := hashPos

instance [Hashable α] : Hashable (NonEmptyList α) where
  hash xs := mixHash (hash xs.head) (hash xs.tail)

-- binary tree
inductive BinTree (α : Type) where
  | leaf : BinTree α
  | branch : BinTree α -> α -> BinTree α -> BinTree α

def eqBinTree [BEq α] : BinTree α -> BinTree α -> Bool
| BinTree.leaf, BinTree.leaf => true
| BinTree.branch l x r, BinTree.branch l2 x2 r2 => x == x2 && eqBinTree l l2 && eqBinTree r r2
| _, _ => false

instance [BEq α] : BEq (BinTree α) where
  beq := eqBinTree

def hashBinTree [Hashable α] : BinTree α -> UInt64
| BinTree.leaf => 0
| BinTree.branch l x r =>
  mixHash 1 (mixHash (hashBinTree l)
              (mixHash (hash x)
                (hashBinTree r)))

-- instance [Hashable α] : Hashable (BinTree α) where
--   hash := hashBinTree

--------------------------------------------------------------------------------
-- deriving standard classes
--------------------------------------------------------------------------------
-- instance deriving
-- deriving Repr
-- deriving instance C1, C2, ... for T
deriving instance BEq, Hashable for Pos
deriving instance BEq, Hashable for NonEmptyList

deriving instance BEq, Hashable for BinTree

/-
Inhabited
BEq
Repr
Hashable
Ord
-/

--------------------------------------------------------------------------------
-- appending
--------------------------------------------------------------------------------
-- HAppend

instance : Append (NonEmptyList α) where
  append xs ys := {head := xs.head, tail := xs.tail ++ ys.head :: ys.tail}
-- { head := "Banded Garden Spider",
--   tail := ["Long-legged Sac Spider",
--            "Wolf Spider",
--            "Hobo Spider",
--            "Cat-faced Spider",
--            "Banded Garden Spider",
--            "Long-legged Sac Spider",
--            "Wolf Spider",
--            "Hobo Spider",
--            "Cat-faced Spider"] }
#eval idahoSpiders ++ idahoSpiders

instance : HAppend (NonEmptyList α) (List α) (NonEmptyList α) where
  hAppend xs ys := {head := xs.head, tail := xs.tail ++ ys}
-- { head := "Banded Garden Spider",
--   tail := ["Long-legged Sac Spider", "Wolf Spider", "Hobo Spider", "Cat-faced Spider", "Trapdoor Spider"] }
#eval idahoSpiders ++ ["Trapdoor Spider"]

--------------------------------------------------------------------------------
-- functors
--
-- https://www.adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html
-- functor: fmap <$>
-- applicative: <*>
-- monad: >>=
--------------------------------------------------------------------------------
-- Functor.map
-- <$>
#eval Functor.map (· + 5) [1,2,3] -- [6, 7, 8]
#eval (· + 5) <$> [1,2,3] -- [6, 7, 8]
#eval toString <$> (some (List.cons 5 List.nil)) -- some "[5]"
#eval List.reverse <$> [[1, 2, 3], [4, 5, 6]] -- [[3, 2, 1], [6, 5, 4]]

instance : Functor NonEmptyList where
  map f xs := {head := f xs.head, tail := f <$> xs.tail}

instance : Functor PPoint where
  map f p := {x := f p.x, y := f p.y}


-- ERROR: No deriving handlers have been implemented for class `ToString`
-- deriving instance ToString for NonEmptyList


--------------------------------------------------------------------------------
-- exercises
--------------------------------------------------------------------------------
