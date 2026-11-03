# The Lean Language Reference
* https://lean-lang.org/doc/reference/latest/

# 1. Introduction/引言
# 2. Elaboration and Compilation/细化与编译
# 3. Interacting with Lean/与Lean交互
# 4. The Type System/类型系统
# 5. Source Files and Modules/源文件和模块

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

# 6. Namespaces and Sections/命名空间与节
# 7. Definitions/定义

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

# 8. Axioms/公理
# 9. Attributes/属性
# 10. Type Classes/类型类
# 11. Coercions/强制转换
# 12. Run-Time Code/运行时代码
# 13. Terms/项
# 14. Tactic Proofs/策略证明
# 15. The Simplifier/化简器
# 16. The `grind` tactic
# 17. The `vcgen` tactic
# 18. The `mvcgen` tactic
# 19. Functors, Monads and `do`-Notation/函子, 单子与`do`记法
# 20. Basic Propositions/基本命题
# 21. Basic Types/基本类型
# 22. IO/输入输出
# 23. Iterators/迭代器
# 24. Notations and Macros/记法与宏
# 25. Build Tools and Distribution/构建工具与分发
# 26. Linters and Code Quality/代码检查工具与代码质量
# Validating a Lean Proof/验证Lean证明
# Error Explanations/错误说明
# Release Notes/发布说明
# Supported Platforms/支持的平台

# See Also
