def hello := "world"

-- 20 KB buffer size
def bufsize : USize := 20 * 1024

-- partial: NOT require a proof to terminate
partial def dump(stream: IO.FS.Stream): IO Unit := do
  let buf <- stream.read bufsize
  if buf.isEmpty then
    pure ()
  else
    -- read from stdin, write to stdout
    let stdout <- IO.getStdout
    stdout.write buf
    -- recursively call dump to read more data
    dump stream

-- IO.FS.Stream: POSIX stream
def fileStream(filename: System.FilePath): IO (Option IO.FS.Stream) := do
  let fileExists <- filename.pathExists
  if not fileExists then
    let stderr <- IO.getStderr
    stderr.putStrLn s!"File not found: {filename}"
    pure none
  else
    -- read from file, return stream of file handle
    let handle <- IO.FS.Handle.mk filename IO.FS.Mode.read
    pure (some (IO.FS.Stream.ofHandle handle))

def process(exitCode: UInt32)(args: List String): IO UInt32 := do
  match args with
  | [] => pure exitCode
  | "-" :: args =>
    -- read from stdin, then dump
    let stdin <- IO.getStdin
    dump stdin
    -- continue
    process exitCode args
  | filename :: args =>
    -- read from file, then dump, then continue
    let stream <- fileStream ⟨filename⟩
    match stream with
    | none => process 1 args
    | some stream =>
      dump stream
      process exitCode args
