# Tools

# elan: Lean version manager
* https://github.com/leanprover/elan

elan is a small tool for managing your installations of the Lean theorem prover. It places `lean` and `lake` binaries in your `PATH` that automatically select and, if necessary, download the Lean version described in your project's `lean-toolchain` file. You can also install, select, run, and uninstall Lean versions manually using the commands of the `elan` executable.

<!--
$  curl -O   --location https://elan.lean-lang.org/elan-init.ps1
$ powershell -ExecutionPolicy Bypass -f elan-init.ps1
info: downloading installer to C:\Users\zhouj\AppData\Local\Temp\

Welcome to Lean!

This will download and install Elan, a tool for managing different Lean
versions used in packages you create or download. It will also install a
default version of Lean and its package manager, lake, for editing files not
belonging to any package.

It will add the lake, lean, and elan commands to Elan's bin directory, located
at:

  C:\Users\zhouj\.elan\bin

This path will then be added to your PATH environment variable by modifying the
HKEY_CURRENT_USER/Environment/PATH registry key.

You can uninstall at any time with elan self uninstall and these changes will
be reverted.

Current installation options:

    *    default toolchain: stable
    * modify PATH variable: yes


1) Proceed with installation (default)
2) Customize installation
3) Cancel installation
1

info: default toolchain set to 'stable'

Elan is installed now. Great!

To get started you need Elan's bin directory (%USERPROFILE%.elan\bin) in your
PATH environment variable. Future applications will automatically have the
correct environment, but you may need to restart your current shell.
0

$ cd ~/.elan/bin
$ ls
elan.exe  lake.exe  lean.exe  leanc.exe  leanchecker.exe  leanmake.exe  leanpkg.exe
-->

# See Also