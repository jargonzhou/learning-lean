import C3OverloaddingAndTypeClasses.S1PositiveNumbers


--------------------------------------------------------------------------------
-- checking polymorphic functions' types
--------------------------------------------------------------------------------
#check (IO.println) -- IO.println : ?m.1 → IO Unit
#check @IO.println -- @IO.println : {α : Type u_1} → [ToString α] → α → IO Unit

--------------------------------------------------------------------------------
-- defining polymorphic functons with instance implicits
--------------------------------------------------------------------------------
-- [...]: instance implicits
def List.sumOfContents [Add α] [Zero α] : List α -> α
  | [] => 0
  | x :: xs => x + xs.sumOfContents

def fourNats : List Nat := [1, 2, 3, 4]
#eval fourNats.sumOfContents -- 10

def fourPos : List Pos := [1, 2, 3, 4]
-- ERROR:
-- failed to synthesize instance of type class
--   Zero Pos
-- #eval fourPos.sumOfContents

structure PPoint (α : Type) where
  x : α
  y : α
-- [...]: instance implicits
instance [Add α] : Add (PPoint α) where
  add p1 p2 := {x := p1.x + p2.x, y := p1.y + p2.y}

--------------------------------------------------------------------------------
-- methods and implicit arguments
--------------------------------------------------------------------------------
#check @OfNat.ofNat -- @OfNat.ofNat : {α : Type u_1} → (x : Nat) → [self : OfNat α x] → α

--------------------------------------------------------------------------------
-- exercises
--------------------------------------------------------------------------------
