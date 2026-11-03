# fp-in-lean-feline

2.4. Worked Example: cat in 'Functional Programming in Lean'.

Setup
```shell
$ lake new fp-in-lean-feline
# or not include a library section
# $ lake new fp-in-lean-feline exe
```

Build and Run
```shell
$ lake build

$ echo "It works!" | lake exe fp-in-lean-feline
It works!

$ lake exe fp-in-lean-feline data/test1.txt data/test2.txt
It's time to find a warm spot
and curl up!

# here - means stdin
$ echo "and purr" | lake exe fp-in-lean-feline data/test1.txt - data/test2.txt
It's time to find a warm spot
and purr
and curl up!
```