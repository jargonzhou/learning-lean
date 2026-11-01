-- definitions: names
def hello := "Hello"
def lean : String := "Lean"
#eval String.append hello (String.append " " lean)

-- functions
def add1 (n : Nat) : Nat := n + 1
#eval add1 7
-- function signature
#check add1 -- add1 (n : Nat) : Nat
-- treat as an expression
#check (add1) -- add1 : Nat → Nat
-- ???
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
