--------------------------------------------------------------------------------
-- automatic implicit parameters
--------------------------------------------------------------------------------
def length {α : Type}(xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (length ys)

def lengthV2(xs : List α) : Nat :=
  match xs with
  | [] => 0
  | _ :: ys => Nat.succ (lengthV2 ys)

--------------------------------------------------------------------------------
-- pattern matching definitions
--------------------------------------------------------------------------------
-- return type is a function type
def lengthV3 : List α -> Nat
  | [] => 0
  | _ :: ys => Nat.succ (lengthV3 ys)

def drop: Nat -> List α -> List α
  | Nat.zero, xs => xs
  | _, [] => []
  | Nat.succ n, _ :: xs => drop n xs

def fromOption(default : α) : Option α -> α
  | none => default
  | some x => x

#eval fromOption "" (some "salmonberry") -- "salmonberry"
#eval fromOption "" none -- ""

--------------------------------------------------------------------------------
-- local definitions
--------------------------------------------------------------------------------
def unzip: List (α × β) -> List α × List β
  | [] => ([], [])
  | (x, y) :: xys => (x :: (unzip xys).fst, y :: (unzip xys).snd)

def unzipV2 : List (α × β) -> List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let unzipped : List α × List β := unzipV2 xys
    (x :: unzipped.fst, y :: unzipped.snd)

def unzipV3 : List (α × β) -> List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let (xs, ys) : List α × List β := unzipV3 xys
    (x :: xs, y :: ys)

-- recursive let
def reverse (xs : List α) : List α :=
  let rec helper : List α -> List α -> List α
    | [], soFar => soFar
    | y :: ys, soFar => helper ys (y :: soFar)
  helper xs []
#eval reverse [1,2,3,4] -- [4, 3, 2, 1]


--------------------------------------------------------------------------------
-- type inference
--------------------------------------------------------------------------------
-- let
def unzipV4 : List (α × β) -> List α × List β
  | [] => ([], [])
  | (x, y) :: xys =>
    let (xs, ys) := unzipV4 xys
    (x :: xs, y :: ys)
-- return type
def unzipV5 (pairs : List (α × β)) :=
  match pairs with
  | [] => ([], [])
  | (x, y) :: xys =>
    let (xs, ys) := unzipV5 xys
    (x :: xs, y :: ys)

def myId(x : α) : α := x

--------------------------------------------------------------------------------
-- simultaneous matching
--------------------------------------------------------------------------------
def dropV2 (n : Nat)(xs : List α) : List α :=
  match n, xs with
    | Nat.zero, ys => ys
    | _, [] => []
    | Nat.succ n, _ :: ys => dropV2 n ys

-- match a pair
-- ERROR:
-- fail to show termination for
--   sameLength
-- def sameLength(xs : List α)(ys : List β) : Bool :=
--   match (xs, ys) with
--   | ([], []) => true
--   | (x :: xs', y :: ys') => sameLength xs' ys'
--   | _ => false

--------------------------------------------------------------------------------
-- natural number patterns
--------------------------------------------------------------------------------
def even(n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (even k)

def evenV2 : Nat -> Bool
  | 0 => true
  | n + 1 => not (even n)

def halve : Nat -> Nat
  | Nat.zero => 0
  | Nat.succ Nat.zero => 0
  | Nat.succ (Nat.succ n) => halve n + 1 -- (halve n) + 1

def halveV2 : Nat -> Nat
  | 0 => 0
  | 1 => 0
  | n + 2 => halveV2 n + 1

--------------------------------------------------------------------------------
-- anonymous functions
--------------------------------------------------------------------------------
#check fun x => x + 1 -- fun x => x + 1 : Nat → Nat
#check fun (x : Int) => x + 1
#check fun { α : Type } (x : α) => x -- fun {α} x => x : {α : Type} → α → α

#check fun
| 0 => none
| n + 1 => some n
-- fun x =>
--   match x with
--   | 0 => none
--   | n.succ => some n : Nat → Option Nat

def double : Nat -> Nat := fun
  | 0 => 0
  | k + 1 => double k + 2

-- ·
#eval (fun x => x + x) 5 -- 10
#eval (· * 2) 5 -- 10

--------------------------------------------------------------------------------
-- namespaces
--------------------------------------------------------------------------------
def Nat.double(x : Nat) : Nat := x + x
#eval (4 : Nat).double -- 8

namespace NewNamespace
def triple (x : Nat) : Nat := 3 * x
def quadruple (x : Nat) : Nat := 2 * x + 2 * x
end NewNamespace

#check NewNamespace.triple -- NewNamespace.triple (x : Nat) : Nat

def timesTwelve (x : Nat) :=
  open NewNamespace in
  quadruple (triple x)

open NewNamespace in
#check quadruple -- NewNamespace.quadruple (x : Nat) : Nat

--------------------------------------------------------------------------------
-- if let
--------------------------------------------------------------------------------
-- markdown inline elements
inductive Inline : Type where
  | lineBreak
  | string : String -> Inline
  | emph : Inline -> Inline
  | strong : Inline -> Inline

def Inline.string? (inline : Inline) : Option String :=
  match inline with
    | Inline.string s => some s
    | _ => none

def Inline.stringV2? (inline : Inline) : Option String :=
  if let Inline.string s := inline then
    some s
  else none

--------------------------------------------------------------------------------
-- positional structure arguments
--------------------------------------------------------------------------------
structure Point where
  x : Nat
  y : Nat

#eval (⟨1, 2⟩ : Point) -- { x := 1, y := 2 }

--------------------------------------------------------------------------------
-- string interpolation
--------------------------------------------------------------------------------
#eval s!"thre five is {NewNamespace.triple 5}" -- "thre five is 15"

-- ERROR:
-- failed to synthesize instance of type class
--   ToString (Nat → Nat)
-- #eval s!"three five is {NewNamespace.triple}"
