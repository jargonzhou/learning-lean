# greeting

2.3. Starting a Project in ' Functional Programming in Lean'.

Setup
```shell
$ lake new greeting
info: downloading https://releases.lean-lang.org/lean4/v4.35.0/lean-4.35.0-windows.tar.zst
593.9 MiB / 593.9 MiB (100 %)   4.3 MiB/s ETA:   0 s
info: installing C:\Users\zhouj\.elan\toolchains\leanprover--lean4---v4.35.0
```

```shell
$ tree
.
|-- Greeting
|   `-- Basic.lean
|-- Greeting.lean       // support library
|-- Main.lean           // main action
|-- README.md
|-- lake-manifest.json
|-- lakefile.toml       // lake build configuration
`-- lean-toolchain      // Lean version
```

Run
```shell
$ lake build
info: greeting: no previous manifest, creating one from scratch
info: toolchain not updated; already up-to-date
Build completed successfully (8 jobs).

$ lake exe greeting
Hello, world!

$ ./.lake/build/bin/greeting.exe 
Hello, world!
```