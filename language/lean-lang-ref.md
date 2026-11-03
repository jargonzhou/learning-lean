# The Lean Language Reference
* https://lean-lang.org/doc/reference/latest/

# 1. Introduction
# 2. Elaboration and Compilation
# 3. Interacting with Lean
# 4. The Type System
# 5. Source Files and Modules

## 5.1. Encoding and Representation
## 5.2. Concrete Syntax
## 5.2.1. Whitespace
## 5.2.2. Comments

- line comments: `-- ...`
- block comments: `/- ... -/`
- document comments: `/-- ... -/`, `/-! ... -/`

## 5.2.3. Keywords and Identifiers
## 5.3. Structure
## 5.3.1. Headers
- `module? …`
- `module? prelude …`
- `prelude`
- `import …`
- `public? meta? import all? …`
## 5.3.2. Commands
## 5.4. Modules and Visibility
- `backward.privateInPublic`
- `backward.privateInPublic.warn`
- `backward.proofsInPublic`
## 5.4.1. The Meta Phase
## 5.5. Elaborated Modules
## 5.6. Module System Errors and Patterns
## 5.6.1. Recipe for Porting Existing Files
## 5.7. Packages, Libraries, and Targets

# 6. Namespaces and Sections
# 7. Definitions

```lean
def
abbrev
example
theorem
opaque
```

## 7.1. Modifiers
## 7.2. Headers and Signatures
## 7.3. Definitions
## 7.4. Theorems
## 7.5. Example Declarations
## 7.6. Recursive Definitions

# 8. Axioms
# 9. Attributes
# 10. Type Classes
# 11. Coercions
# 12. Run-Time Code
# 13. Terms
# 14. Tactic Proofs
# 15. The Simplifier
# 16. The grind tactic
# 17. The vcgen tactic
# 18. The mvcgen tactic
# 19. Functors, Monads and do-Notation
# 20. Basic Propositions
# 21. Basic Types
# 22. IO
# 23. Iterators
# 24. Notations and Macros
# 25. Build Tools and Distribution
# 26. Linters and Code Quality
# Validating a Lean Proof
# Error Explanations
# Release Notes
# Supported Platforms
# Index