-- definitions: names
def hello := "Hello"
def lean : String := "Lean"
#eval String.append hello (String.append " " lean)

--------------------------------------------------------------------------------
-- define functions
--------------------------------------------------------------------------------
def add1 (n : Nat) : Nat := n + 1
#eval add1 7
-- function signature
#check add1 -- add1 (n : Nat) : Nat
-- treat as an expression
#check (add1) -- add1 : Nat → Nat
-- example declarations: anonymous definition, elaborated then discarded
example: Nat -> Nat := add1

-- multiple arguments
def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then
    k
  else n
#eval maximum (5 + 8) (2 * 7)
#check maximum -- maximum (n k : Nat) : Nat
-- → associate right: Nat → (Nat → Nat)
#check (maximum) -- maximum : Nat → Nat → Nat
#check maximum 3 -- maximum 3 : Nat → Nat


def spaceBetween (before : String) (after : String) : String :=
  String.append before (String.append " " after)
#check spaceBetween "Hello " -- spaceBetween "Hello " : String → String


def joinStringsWith(sep : String) (s1 : String) (s2 : String) : String :=
  String.append s1 (String.append sep s2)
#eval joinStringsWith ", " "one" "and another" -- "one, and another"
#check (joinStringsWith ": ") -- joinStringsWith ": " : String → String → String

def volumn(height: Nat)(width: Nat)(depth: Nat): Nat :=
  height * width * depth
#eval volumn 2 3 4 -- 24

--------------------------------------------------------------------------------
-- define types
--------------------------------------------------------------------------------
def Str : Type := String
def aStr : Str := "This is a string."

def NaturalNumber : Type := Nat
-- ERROR:
-- failed to synthesize instance of type class
--   OfNat NaturalNumber 38
-- numerals are polymorphic in Lean, but the numeral `38` cannot be used in a context where the expected type is
--   NaturalNumber
-- due to the absence of the instance above

-- Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-- Error code: lean.synthInstanceFailed
-- def thirtyEight: NaturalNumber := 38
def thirtyEight: NaturalNumber := (38 : Nat)


abbrev N : Type := Nat
def thirtyNine : N := 39
