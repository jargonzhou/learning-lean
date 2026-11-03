# fp-in-lean
```shell
$ lake new fp-in-lean
```

# 2. Hello World!

Run a Program
```shell
$ lean --run S1Hello.lean 
Hello, world!

$ lean --run S1HelloName.lean 
How would you like to bre addressed?
David
Hello, David!

$ lean --run S2StepByStep.lean 
5...
4...
3...
2...
1...
Blast off!
```

- Example: ~~greeting~~fp-in-lean

2.3. Starting a Project in 'Functional Programming in Lean'.

Setup
```shell
$ lake new fp-in-lean
info: downloading https://releases.lean-lang.org/lean4/v4.35.0/lean-4.35.0-windows.tar.zst
593.9 MiB / 593.9 MiB (100 %)   4.3 MiB/s ETA:   0 s
info: installing ~\.elan\toolchains\leanprover--lean4---v4.35.0
```

```shell
$ tree
.
├── FpInLean
│   ├── Basic.lean
│   └── Smile.lean
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
Build completed successfully (8 jobs).

$ lake exe fp-in-lean
Hello, world, with a big sime!

$ ./.lake/build/bin/fp-in-lean.exe 
Hello, world, with a big sime!
```