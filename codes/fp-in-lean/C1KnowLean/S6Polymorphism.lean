-- polymorphic structure
structure PPoint(α: Type) where
  x: α
  y: α

def natOrigin: PPoint Nat := { x := 0, y := 0 }
#eval natOrigin -- { x := 0, y := 0 }

-- type arguments in definition
def replaceX(α: Type)(p: PPoint α)(newX: α): PPoint α :=
  { p with x := newX }
#check (replaceX) -- (α : Type) → PPoint α → α → PPoint α
#check replaceX Nat -- replaceX Nat : PPoint Nat → Nat → PPoint Nat
#check replaceX Nat natOrigin -- replaceX Nat natOrigin : Nat → PPoint Nat
#check replaceX Nat natOrigin 5 -- replaceX Nat natOrigin 5 : PPoint Nat
#eval replaceX Nat natOrigin 5 -- { x := 5, y := 0 }

-- different type of definition
inductive Sign where
  | pos : Sign
  | neg : Sign
def posOrNegThree(s: Sign): match s with
  | Sign.pos => Nat
  | Sign.neg => Int
  := match s with
  | Sign.pos => 3
  | Sign.neg => -3
#check (posOrNegThree)
-- (s : Sign) →
--   match s with
--   | Sign.pos => Nat
--   | Sign.neg => Int
#eval posOrNegThree Sign.pos -- 3
#eval posOrNegThree Sign.neg -- -3

--------------------------------------------------------------------------------
-- linked list
--------------------------------------------------------------------------------
def primesUnder10 : List Nat := [2,3,5,7]
def explicitPrimesUnder10 : List Nat :=
  List.cons 2 (List.cons 3 (List.cons 5 (List.cons 7 List.nil)))

def length(α : Type)(xs: List α) : Nat :=
  match xs with
  | List.nil => Nat.zero
  | List.cons _ ys => Nat.succ (length α ys)
#eval length String ["Sourdough", "bread"] -- 2

def lengthV2(α : Type)(xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length α ys)

--------------------------------------------------------------------------------
-- implicit arguments: {}
--------------------------------------------------------------------------------
-- an implicit type argument
def replaceXV2 {α : Type}(point: PPoint α)(newX : α): PPoint α :=
  {point with x := newX}
#eval replaceXV2 natOrigin 5 -- { x := 5, y := 0 }

def lengthV3{α : Type}(xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (lengthV3 ys)

#eval lengthV3 primesUnder10 -- 4
-- List.length
#eval primesUnder10.length -- 4
#check List.length (α := Int)

--------------------------------------------------------------------------------
-- built-in data types
--
-- Option: none, some
-- Prod: fst, snd - ×
-- Sum: inl, inr - ⊕
-- Unit: unit
-- Empty
--------------------------------------------------------------------------------
#eval primesUnder10.head?  -- some 2
-- don't know how to synthesize implicit argument `α`
--   @List.head? ?m.3 []
-- context:
-- ⊢ Type ?u.3
-- #eval [].head?
#eval [].head? (α := Int) -- none
#eval ([] : List Int).head? -- none

def fives: String × Int := {fst := "five", snd := 5}
def fivesV2 : String × Int := ("five", 5)
def sevens : String × Int × Nat := ("VII", 7, 4 + 3)
-- ×: right associative
def sevensV2 : String × (Int × Nat) := ("VII", (7, 4 + 3))

def PetName : Type := String ⊕ String
def animals : List PetName :=
  [Sum.inl "Spot", Sum.inr "Tiger", Sum.inl "Fifi",
  Sum.inl "Rex", Sum.inr "Floof"]

def howManyDogs(pets: List PetName) : Nat :=
  match pets with
  | [] => 0
  | Sum.inl _ :: morePets => howManyDogs morePets + 1
  | Sum.inr _ :: morePets => howManyDogs morePets

inductive ArithExpr(ann : Type) : Type where
  | int: ann -> Int -> ArithExpr ann
  | plus: ann -> ArithExpr ann -> ArithExpr ann -> ArithExpr ann
  | minus : ann -> ArithExpr ann -> ArithExpr ann -> ArithExpr ann
  | times : ann -> ArithExpr ann -> ArithExpr ann -> ArithExpr ann
#check ArithExpr Unit -- ArithExpr Unit : Type


-- ctor: constructor

-- ERROR:
-- Invalid universe level in constructor `MyType.ctor`: Parameter `α` has type
--   Type
-- at universe level
--   2
-- which is not less than or equal to the inductive type's resulting universe level
--   1
-- inductive MyType : Type where
--   | ctor : (α : Type) -> α -> MyType

-- ERROR:
-- (kernel) arg #1 of 'MyType.ctor' has a non positive occurrence of the datatypes being declared
-- inductive MyType : Type where
--   | ctor : (MyType -> Int) -> MyType

-- match against pair
-- ERROR:
-- fail to show termination for
--   sameLength
-- def sameLength(xs : List α)(ys : List β) : Bool :=
--   match (xs, ys) with
--   | ([], []) => true
--   | (x :: xs', y :: ys') => sameLength xs' ys'
--   | _ => false

-- use nested pattern matching
def sameLength(xs : List α)(ys : List β) : Bool :=
  match xs with
  | [] =>
    match ys with
    | [] => true
    | _ => false
  | _ :: xs' =>
    match ys with
    | _ :: ys' => sameLength xs' ys'
    | _ => false

inductive MyType (α : Type) : Type where
  | ctor : α -> MyType α

def ofFive : MyType Nat := MyType.ctor 5

inductive WoodSplittingTool where
  | axe
  | maul
  | froe
#eval WoodSplittingTool.axe -- WoodSplittingTool.axe
def allTools : List WoodSplittingTool := [
  WoodSplittingTool.axe,
  WoodSplittingTool.maul,
  WoodSplittingTool.froe
]
-- ERROR:
-- could not synthesize a `Repr` or `ToString` instance for type
--   List WoodSplittingTool
-- #eval allTools

inductive Firewood where
  | birch
  | pine
  | beech
deriving Repr
def allFirewood : List Firewood := [
  Firewood.birch,
  Firewood.pine,
  Firewood.beech
]
#eval allFirewood -- [Firewood.birch, Firewood.pine, Firewood.beech]

def last(α : Type)(lst : List α): Option α :=
  match lst with
  | [] => none
  | _ :: rest => last α rest
def List.findFirst? {α : Type} (xs : List α) (predicate : α → Bool) : Option α :=
  match xs with
  | [] => none
  | x :: rest => if (predicate x) then some x else List.findFirst? rest predicate

def Prod.swith {α β : Type} (pair : α × β) : β × α :=
  {fst := pair.snd, snd := pair.fst}

structure Name (α : Type) where
  name : α
deriving Repr

def PetNameV2(α : Type) := Name α
def animalsV2 : List (PetNameV2 String) :=
  [{name := "Spot"}, {name := "Tiger"}, {name := "Fifi"},
  {name := "Rex"}, {name := "Floof"}]
#eval animalsV2 -- [{ name := "Spot" }, { name := "Tiger" }, { name := "Fifi" }, { name := "Rex" }, { name := "Floof" }]

def zip {α β : Type} (xs : List α) (ys : List β) : List (α × β) :=
  match xs with
  | [] => []
  | x :: xs' =>
    match ys with
    | [] => []
    | y :: ys' => (x, y) :: zip xs' ys'

def take {α : Type} (n : Nat)(lst : List α): List α :=
  match lst with
  | [] => []
  | x :: xs => if (n > 0) then x :: take (n-1) xs else []

#eval take 3 ["bolete", "oyster"] -- ["bolete", "oyster"]
#eval take 1 ["bolete", "oyster"] -- ["bolete"]

-- def distributeProductOverSum {α β γ : Type} (v : Prod α (Sum β γ)) : Sum (Prod α β) (Prod β γ) :=
def distributeProductOverSum {α β γ : Type} (v : α × (β ⊕ γ)) : (α × β) ⊕ (α × γ) :=
  let v1 := v.fst --  α
  let v2 := v.snd -- β ⊕ γ
  match v2 with
    | Sum.inl x => Sum.inl (v1, x)
    | Sum.inr x => Sum.inr (v1, x)

#eval distributeProductOverSum ((2 : Nat), (Sum.inl 3 : Sum Nat Nat)) -- Sum.inl (2, 3)
#eval distributeProductOverSum ((2 : Nat), (Sum.inr 4 : Sum Nat Nat)) -- Sum.inl (2, 4)


def turnMultiplicationByTwoIntoSum {α : Type}(v : Bool × α): α ⊕ α :=
  let flag := v.fst
  if flag then
    Sum.inl v.snd
  else
    Sum.inr v.snd

#eval turnMultiplicationByTwoIntoSum (true, (3 : Nat)) -- Sum.inl 3
#eval turnMultiplicationByTwoIntoSum (false, (3 : Nat)) -- Sum.inr 3
