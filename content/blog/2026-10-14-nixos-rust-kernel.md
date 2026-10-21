---
title: "NixOS Rust-for-Linux"
date: 2026-10-14T01:52:09+08:00
draft: false
---

Assuming you mean Rust-for-Linux (in-tree kernel modules), the usual workflow is a dev shell for the build plus QEMU for testing, rather than booting the kernel on your NixOS machine.

**1. Dev shell** (`shell.nix`, channels-style):
```
```
```nix
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    gnumake flex bison bc pkg-config ncurses
    llvmPackages.clang llvmPackages.lld llvmPackages.libclang
    rustc cargo rust-bindgen rustfmt clippy rust-analyzer
    openssl elfutils perl qemu busybox
  ];
  RUST_LIB_SRC = "${pkgs.rustPlatform.rustLibSrc}";
  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
  hardeningDisable = [ "all" ];
}
```

`hardeningDisable` matters because Nix's default hardening flags break kernel builds.

**2. Toolchain version:** each kernel release needs a specific minimum rustc and bindgen version. Check with `make LLVM=1 rustavailable`. If nixpkgs is too new or too old, pin one with `rust-overlay` or `fenix` (you'll need the `rust-src` component).

**3. Build loop:**

```
make LLVM=1 defconfig
make LLVM=1 menuconfig        # General setup -> Rust support
make LLVM=1 -j$(nproc)
make LLVM=1 rust-analyzer     # generates rust-project.json for your editor
make LLVM=1 rustfmtcheck clippy
```

For fast iteration, use a minimal config: `make LLVM=1 allnoconfig qemu-busybox-min.config rust.config`.

**4. Test in QEMU:** build a busybox initramfs (nixpkgs has a static busybox via `pkgsStatic.busybox`), then boot `arch/x86/boot/bzImage` with `-nographic -append "console=ttyS0"`. Use `-s -S` and `gdb vmlinux` for debugging. Keep sample modules under `samples/rust/` and enable them as `=m` or `=y`.

**5. Out-of-tree modules:** Rust out-of-tree support is still rough. If you try it, the kernel needs to be built with `CONFIG_RUST=y` and you need `kernel.dev` headers. On NixOS that means `boot.kernelPackages.kernel.dev` plus `kernel.moduleBuildDependencies`, and the kernel itself must be a Rust-enabled build (via `structuredExtraConfig = { RUST = lib.kernel.yes; }` and adding `rustc`, `rust-bindgen` and `rustPlatform.rustLibSrc` to its build inputs). In-tree plus QEMU is far less painful.

If you meant writing your own hobby kernel in Rust (bare-metal target, `bootimage`, etc.), that's a different setup, and I can sketch that one too.
