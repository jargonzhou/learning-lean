#eval 1 + 2
#eval 1 + 2 * 5
#eval String.append "Hello, " "Lean!"
#eval String.append "great " (String.append "oak " "tree")
#eval String.append "it is " (if 1 > 2 then "yes" else "no")


-- ERROR: could not synthesize a `Repr` or `ToString` instance for type
-- String → String
-- #eval String.append "it is"


#eval 42 + 19 -- 61
#eval String.append "A" (String.append "B" "C") -- "ABC"
#eval String.append (String.append "A" "B") "C" -- "ABC"
#eval if 3 == 3 then 5 else 7 -- 5
#eval if 3 == 4 then "equal" else "not equal" -- "not equal"
