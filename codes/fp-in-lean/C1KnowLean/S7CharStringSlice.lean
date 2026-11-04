#eval "Hello, " ++ "world" -- "Hello, world"
#eval String.push "Hello" '!' -- "Hello!"
#eval "Hello".push '!' -- "Hello!"

--------------------------------------------------------------------------------
-- slices
--------------------------------------------------------------------------------
#eval (("small tortoiseshell".drop 6).dropEnd 5).copy -- "tortoise"

--------------------------------------------------------------------------------
-- matching
--------------------------------------------------------------------------------
#eval "red admiral".dropEndWhile 'l' -- red admira
#eval "the the butterfly".dropWhile "the " -- butterfly
#eval ("a gray grayling".drop 2).dropWhile "gray " -- grayling
#eval ("red admiral".dropEndWhile Char.isAlpha).copy -- "red "


-- ERROR:
-- don't know how to synthesize implicit argument `ρ`
--   @String.dropEndWhile ?m.2 "red admiral"
-- context:
-- ⊢ Type
-- #eval "red admiral".dropEndWhile

-- ERROR:
-- failed to synthesize instance of type class
--   String.Slice.Pattern.BackwardPattern [12]
-- #eval "12345abcde".dropEndWhile [12]
