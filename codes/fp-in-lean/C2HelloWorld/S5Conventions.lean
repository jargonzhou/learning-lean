-- use import
import C2HelloWorld.S2StepByStep

--
-- nested actions: (<- xxx)
--
-- partial def dump(stream: IO.FS.Stream): IO Unit := do
--   let buf <- stream.read (10 * 1024)
--   if buf.isEmpty then
--     pure ()
--   else
--     let stdout <- IO.getStdout
--     stdout.write buf
--     dump stream
partial def dump(stream: IO.FS.Stream): IO Unit := do
  let buf <- stream.read (10 * 1024)
  if buf.isEmpty then
    pure ()
  else
    (<- IO.getStdout).write buf
    dump stream


-- def fileStream(filename: System.FilePath): IO (Option IO.FS.Stream) := do
--   let fileExists <- filename.pathExists
--   if not fileExists then
--     let stderr <- IO.getStderr
--     stderr.putStrLn s!"File not found: {filename}"
--     pure none
--   else
--     let handle <- IO.FS.Handle.mk filename IO.FS.Mode.read
--     pure (some (IO.FS.Stream.ofHandle handle))

def fileStream(filename: System.FilePath): IO (Option IO.FS.Stream) := do
  if not (<- filename.pathExists) then
    (<- IO.getStderr).putStrLn s!"File not found: {filename}"
    pure none
  else
    let handle <- IO.FS.Handle.mk filename IO.FS.Mode.read
    pure (some (IO.FS.Stream.ofHandle handle))

--
-- nested actions cannot be lifted from the branches of an if
--
def getNumA: IO Nat := do
  (<- IO.getStdout).putStrLn "A"
  pure 5

def getNumB : IO Nat := do
  (<- IO.getStdout).putStrLn "B"
  pure 7

-- ERROR: Nested action `← getNumB` must be nested inside a `do` expression.
-- def test: IO Unit := do
--   let a : Nat := if (<- getNumA) == 5 then 0 else (<- getNumB)
--   (<- IO.getStdout).putStrLn s!"The answer is {a}"


--
-- layouts for `do`
--
-- only whitespaces
def v1 : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout

  stdout.putStrLn "How would you like to be addressed?"
  let name := (← stdin.getLine).trimAscii
  stdout.putStrLn s!"Hello, {name}!"
-- explicit: ;, {}
def v2 : IO Unit := do {
  let stdin ← IO.getStdin;
  let stdout ← IO.getStdout;

  stdout.putStrLn "How would you like to be addressed?";
  let name := (← stdin.getLine).trimAscii;
  stdout.putStrLn s!"Hello, {name}!"
}
-- use ; to put 2 actions on the same line
def v3 : IO Unit := do
  let stdin ← IO.getStdin; let stdout ← IO.getStdout

  stdout.putStrLn "How would you like to be addressed?"
  let name := (← stdin.getLine).trimAscii
  stdout.putStrLn s!"Hello, {name}!"

-- run IO actions with #eval
-- #eval runActions (countdown 3)
-- 3...
-- 2...
-- 1...
-- Blast off!
