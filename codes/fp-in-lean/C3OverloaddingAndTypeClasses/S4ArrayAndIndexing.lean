import C3OverloaddingAndTypeClasses.S1PositiveNumbers
import C3OverloaddingAndTypeClasses.S2TypeClassesAndPolymorphism

--------------------------------------------------------------------------------
-- arrays
--------------------------------------------------------------------------------
def northernTrees : Array String :=
  #["sloe", "birch", "elm", "oak"] -- with #

#check northernTrees -- northernTrees : Array String
#eval northernTrees -- #["sloe", "birch", "elm", "oak"]
#eval northernTrees.size -- 4
#eval northernTrees[0] -- "sloe"
-- ERROR: failed to prove index is valid, possible solutions: ...
-- #eval northernTrees[8]

--------------------------------------------------------------------------------
-- non-empty lists
--------------------------------------------------------------------------------
structure NonEmptyList (α : Type) : Type where
  head : α
  tail : List α

def idahoSpiders : NonEmptyList String := {
  head := "Banded Garden Spider",
  tail := [
    "Long-legged Sac Spider",
    "Wolf Spider",
    "Hobo Spider",
    "Cat-faced Spider"
  ]
}

def NonEmptyList.get? : NonEmptyList α -> Nat -> Option α
  | xs, 0 => some xs.head
  | xs, n + 1 => xs.tail[n]?

abbrev NonEmptyList.inBounds (xs : NonEmptyList α) (i : Nat) : Prop :=
  i ≤ xs.tail.length

theorem atLeastThreeSpiders : idahoSpiders.inBounds 2 := by decide
theorem notSixSpiders : ¬ idahoSpiders.inBounds 5 := by decide

def NonEmptyList.get (xs : NonEmptyList α) (i : Nat) (ok : xs.inBounds i) : α :=
  match i with
    | 0 => xs.head
    | n + 1 => xs.tail[n]

--------------------------------------------------------------------------------
-- overloading indexing
--------------------------------------------------------------------------------
-- xs[]
-- #check @GetElem
instance : GetElem (NonEmptyList α) Nat α NonEmptyList.inBounds where
  getElem := NonEmptyList.get

#eval idahoSpiders[0] -- "Banded Garden Spider"
-- ERROR: failed to prove index is valid, possible solutions: ...
-- #eval idahoSpiders[9]

instance : GetElem (List α) Pos α
  (fun list n => list.length > n.toNat) where
  getElem (xs : List α) (i : Pos) ok := xs[i.toNat]

#eval [seven, fourteen][0] -- 7
#eval [seven, fourteen][1] -- 14

instance : GetElem (PPoint α) Bool α (fun _ _ => True) where
  getElem (p : PPoint α) (i : Bool) _ :=
    if not i then p.x else p.y

#eval {x := 1, y := 2 : PPoint Nat}[false] -- 1
#eval {x := 1, y := 2 : PPoint Nat}[true] -- 2
