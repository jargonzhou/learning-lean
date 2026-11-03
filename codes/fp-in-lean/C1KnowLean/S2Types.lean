#eval (1 + 2 : Nat)
#eval (1 - 2 : Nat) -- 0
#eval (1 - 2 : Int)
#check (1 - 2 : Int) -- 1 - 2 : Int

-- ERROR:
-- Application type mismatch: The argument
--   ["hello", " "]
-- has type
--   List String
-- but is expected to have type
--   String
-- in the application
--   String.append ["hello", " "]
-- #check String.append ["hello", " "] "world"
