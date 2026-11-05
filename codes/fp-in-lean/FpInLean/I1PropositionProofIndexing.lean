-- Interlude: Propositions, Proofs, and Indexing

--------------------------------------------------------------------------------
-- indexing
--------------------------------------------------------------------------------

def woodlandCritters : List String :=
  ["hedgehog", "deer", "snail"]

def hedgehog := woodlandCritters[0]
def deer := woodlandCritters[1]
def snail := woodlandCritters[2]

-- ERROR:
-- failed to prove index is valid, possible solutions:
--   - Use `have`-expressions to prove the index is valid
--   - Use `a[i]!` notation instead, runtime check is performed, and 'Panic' error message is produced if index is not valid
--   - Use `a[i]?` notation instead, result is an `Option` type
--   - Use `a[i]'h` notation instead, where `h` is a proof that index is valid
-- ⊢ 3 < woodlandCritters.length
-- def oops := woodlandCritters[3]

--------------------------------------------------------------------------------
-- propositions, proofs
--------------------------------------------------------------------------------
-- rfl: reflexive
-- WARNING: Definition `onePlusOneIsTwo` is a proposition; use `theorem` instead of `def`
-- def onePlusOneIsTwo : 1 + 1 = 2 := rfl

def OnePlusOneIsTwo : Prop := 1 + 1 = 2
theorem onePlusOneIsTwo : OnePlusOneIsTwo := rfl -- Goals accomplished!

--------------------------------------------------------------------------------
-- tactics:
-- decide
-- simp
-- grind
--------------------------------------------------------------------------------
theorem onePlusOneIsTwoV2 : 1 + 1 = 2 := by decide -- Goals accomplished!

--------------------------------------------------------------------------------
-- connectives

-- evidences:
-- True : True.intro : True
-- False: no evidence
-- A ∧ B: And.intro : A → B → A ∧ B
-- A ∨ B: Or.inl : A → A ∨ B, Or.inr : B → A ∨ B
-- A → B: a function transform evidence of A into evidence of B
-- ¬ A  : a function transform evidence of A into evidence of False
--------------------------------------------------------------------------------
-- use decide to prove theorems using connectives
theorem onePlusOneOrLessThan : 1 + 1 = 2 ∨ 3 < 5 := by decide
theorem notTwoEqualFive : ¬(1 + 1 = 5) := by decide
theorem trueIsTrue : True := by decide
theorem trueOrFalse : True ∨ False := by decide
theorem falseImpliesTrue : False -> True := by decide

--------------------------------------------------------------------------------
-- evidence as arguments
--------------------------------------------------------------------------------
def third(xs : List α) (ok : xs.length > 2) : α := xs[2]
-- `by decide` to construct evidence
#eval third woodlandCritters (by decide) -- "snail"

--------------------------------------------------------------------------------
-- indexing without evidence
--------------------------------------------------------------------------------
def thirdOption (xs : List α) : Option α := xs[2]?
#eval thirdOption woodlandCritters -- some "snail"
#eval thirdOption ["only", "two"] -- none
#eval woodlandCritters[1]! -- "deer"

-- ERROR:
-- Tactic `decide` proved that the proposition
--   ["rabbit"].length > 2
-- is false
-- #eval third ["rabbit"] (by decide)

-- ERROR: `simp` made no progress
-- theorem onePlusOneIsStillTwo : OnePlusOneIsTwo := by simp

-- ERROR:
-- failed to synthesize
--   Decidable OnePlusOneIsTwo
-- theorem onePlusOneIsStillTwo : OnePlusOneIsTwo := by decide

-- ERROR:
-- failed to synthesize instance of type class
--   Inhabited α
-- def unsafeThird(xs : List α) : α := xs[2]!


-- note the whitespace
-- ERROR:
-- Function expected at
--   woodlandCritters
-- but this term has type
--   List String
-- #eval woodlandCritters [1]

theorem theorem1 : 2 + 3 = 5 := rfl
theorem theorem2 : 15 - 8 = 7 := rfl
theorem theorem3 : "Hello, ".append "world" = "Hello, world" := rfl
-- ERROR:
-- Type mismatch
--   rfl
-- has type
--   ?m.9 = ?m.9
-- but is expected to have type
--   5 < 18
-- theorem theorem4 : 5 < 18 := rfl
#check 5 < 18 -- 5 < 18 : Prop

theorem theorem5 : 2 + 3 = 5 := by decide
theorem theorem6 : 15 - 8 = 7 := by decide
theorem theorem7 : "Hello, ".append "world" = "Hello, world" := by decide
theorem theorem8 : 5 < 18 := by decide

def fifth(xs : List α)(ok : xs.length > 4) : α := xs[4]
#eval fifth [1,2,3,4,5] (by decide) -- 5
-- ERROR:
-- Tactic `decide` proved that the proposition
--   [1, 2, 3, 4].length > 4
-- is false
-- #eval fifth [1,2,3,4] (by decide)
