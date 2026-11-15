---
title: "2026 11 15 Rust Vm Setup"
date: 2026-11-15T21:56:36+08:00
draft: false
---

directory structure:

```
vm
└── kernel
    ├── dev
    │   ├── debian-13.7.0-arm64-netinst.iso
    │   ├── debian-dev.qcow2
    │   ├── efi-code.fd
    │   └── efi-vars.fd
    ├── shared
    └── test
```

Populate the directories:

```
cd ~/vm/kernel/dev

qemu-img create -f qcow2 debian-dev.qcow2 100G

QEMU_SHARE="$(brew --prefix qemu)/share/qemu"

cp "$QEMU_SHARE/edk2-aarch64-code.fd" ./efi-code.fd
cp "$QEMU_SHARE/edk2-arm-vars.fd" ./efi-vars.fd

```

The vm installation command:

```
qemu-system-aarch64 \
  -name rust-linux-dev \
  -machine virt,highmem=on \
  -accel hvf \
  -cpu host \
  -smp 6 \
  -m 8192 \
  -drive if=pflash,format=raw,readonly=on,file=efi-code.fd \
  -drive if=pflash,format=raw,file=efi-vars.fd \
  -drive if=none,file=debian-dev.qcow2,format=qcow2,id=hd0 \
  -device virtio-blk-pci,drive=hd0 \
  -device qemu-xhci,id=xhci \
  -device usb-kbd,bus=xhci.0 \
  -drive if=none,file=debian-13.7.0-arm64-netinst.iso,format=raw,media=cdrom,id=cd0 \
  -device usb-storage,bus=xhci.0,drive=cd0 \
  -device virtio-gpu-pci \
  -display cocoa \
  -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-rng-pci
```

Troubleshooting normal vm commamnd:

```
qemu-system-aarch64 \
  -name rust-linux-dev \
  -machine virt,highmem=on \
  -accel hvf \
  -cpu host \
  -smp 6 \
  -m 8192 \
  -drive if=pflash,format=raw,readonly=on,file=efi-code.fd \
  -drive if=pflash,format=raw,file=efi-vars.fd \
  -drive if=none,file=debian-dev.qcow2,format=qcow2,id=hd0 \
  -device virtio-blk-pci,drive=hd0 \
  -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-rng-pci \
  -nographic

```

Normal runing command:

```
qemu-system-aarch64 \
  -name rust-linux-dev \
  -machine virt,highmem=on \
  -accel hvf \
  -cpu host \
  -smp 6 \
  -m 8192 \
  -drive if=pflash,format=raw,readonly=on,file=efi-code.fd \
  -drive if=pflash,format=raw,file=efi-vars.fd \
  -drive if=none,file=debian-dev.qcow2,format=qcow2,id=hd0 \
  -device virtio-blk-pci,drive=hd0 \
  -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-rng-pci \
-display none \
-serial file:/tmp/rust-dev-serial.log \
-monitor unix:/tmp/rust-dev-monitor.sock,server=on,wait=off \
-pidfile /tmp/rust-dev.pid \
-daemonize

```

Some minor issues:

Network settings:

The device is `esp0s2`. However, in `/etc/network/interfaces`, it is `esp0s4`. After changing the correct device and restart the network service, the vm can be remotely accessed.

Hosthamectl gives rubbish in the `Chassis: ` entry:

```
hostnamectl
Failed to query product UUID, ignoring: Access denied
Failed to query hardware serial, ignoring: Access denied
 Static hostname: ferrum
       Icon name: computer-vm
         Chassis: vm 🖴
      Machine ID: 2c427355ee4548a5860bd29b3f4a728b
         Boot ID: 01fdcfe271614ec1adf55f9c2a7184ac
  Virtualization: qemu
Operating System: Debian GNU/Linux 13 (trixie)
          Kernel: Linux 6.12.117+deb13-arm64
    Architecture: arm64
 Hardware Vendor: QEMU
  Hardware Model: QEMU Virtual Machine
Firmware Version: edk2-stable202408-prebuilt.qemu.org
   Firmware Date: Tue 2024-08-13
    Firmware Age: 2y 3month 2d


```

It is a minor issue.
