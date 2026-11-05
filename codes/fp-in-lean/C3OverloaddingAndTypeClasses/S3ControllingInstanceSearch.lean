import C3OverloaddingAndTypeClasses.S1PositiveNumbers

def addNatPos : Nat -> Pos -> Pos
  | 0, p => p
  | n + 1, p => Pos.succ (addNatPos n p)

def addPosNat : Pos -> Nat -> Pos
  | p, 0 => p
  | p, n + 1 => Pos.succ (addPosNat p n)

--------------------------------------------------------------------------------
-- heterogeneous overloading
--------------------------------------------------------------------------------
-- HAdd
instance : HAdd Nat Pos Pos where
  hAdd := addNatPos

instance : HAdd Pos Nat Pos where
  hAdd := addPosNat

#eval (3 : Pos) + (5 : Nat) -- 8
#eval (3 : Nat) + (5 : Pos) -- 8

-- HPlus
class HPlus (α : Type) (β : Type) (γ : Type) where
  hPlus : α -> β -> γ

instance : HPlus Nat Pos Pos where
  hPlus := addNatPos
instance : HPlus Pos Nat Pos where
  hPlus := addPosNat

-- ERROR:
-- typeclass instance problem is stuck
--   HPlus Pos Nat ?m.6
-- Note: Lean will not try to resolve this typeclass instance problem because
-- the third type argument to `HPlus` is a metavariable.
-- This argument must be fully determined before Lean will try to resolve the typeclass.
-- #eval toString (HPlus.hPlus (3 : Pos) (5 : Nat))
#eval (HPlus.hPlus (3 : Pos) (5 : Nat) : Pos) -- 8

--------------------------------------------------------------------------------
-- output parameters
--------------------------------------------------------------------------------
class HPlusV2 (α : Type) (β : Type) (γ : outParam Type) where
  hPlus : α -> β -> γ

instance : HPlusV2 Nat Pos Pos where
  hPlus := addNatPos
instance : HPlusV2 Pos Nat Pos where
  hPlus := addPosNat

#eval HPlusV2.hPlus (3 : Pos) (5 : Nat) -- 8


--------------------------------------------------------------------------------
-- default instances
--------------------------------------------------------------------------------
-- instance [Add α] : HPlusV2 α α α where
--   hPlus := Add.add

@[default_instance] -- attribute
instance [Add α] : HPlusV2 α α α where
  hPlus := Add.add

#check HPlusV2.hPlus (3 : Nat) (5 : Nat) -- HPlusV2.hPlus 3 5 : Nat
-- ?m: metavariable
-- #check HPlusV2.hPlus (3 : Nat) -- HPlusV2.hPlus 3 : ?m.2 → ?m.3
#check HPlusV2.hPlus (3 : Nat) -- HPlusV2.hPlus 3 : Nat → Nat

--------------------------------------------------------------------------------
-- exercises
--------------------------------------------------------------------------------
