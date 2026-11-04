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
