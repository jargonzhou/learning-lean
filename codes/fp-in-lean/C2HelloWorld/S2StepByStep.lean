-- #eval "Hello!!!".dropEndWhile (· == '!')
-- Hello
-- #eval "Hello...   ".dropEndWhile (fun c => not (c.isAlphanum))
-- Hello


-- IO actions as values
def twice(action: IO Unit): IO Unit := do
  action
  action

-- #eval twice (IO.println "shy")
-- shy
-- shy

def nTimes(action: IO Unit): Nat -> IO Unit
  | 0 => pure ()
  | n + 1 => do
    action
    nTimes action n
-- #eval nTimes (IO.println "Hello") 3
-- Hello
-- Hello
-- Hello

-- IO actions are first-class values
def countdown: Nat -> List (IO Unit)
  | 0 => [IO.println "Blast off!"]
  | n + 1 => IO.println s!"{n + 1}..." :: countdown n

def runActions: List (IO Unit) -> IO Unit
  | [] => pure ()
  | action :: actions => do
    action
    runActions actions

def from5: List (IO Unit) := countdown 5
-- #eval runActions (countdown 3)
-- 3...
-- 2...
-- 1...
-- Blast off!
-- #eval runActions from5
-- 5...
-- 4...
-- 3...
-- 2...
-- 1...
-- Blast off!

def main: IO Unit := runActions from5
