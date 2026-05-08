# Initramfs Rebuild Procedure

## Objective

Rebuild and validate the initramfs image in a RHEL 9.6 enterprise Linux environment to recover systems affected by boot failures, missing drivers, or corrupted initramfs images.

---

# Why It Matters

Initramfs corruption can prevent enterprise Linux systems from booting properly.

Common causes include:

- failed kernel upgrades
- missing storage drivers
- corrupted initramfs images
- disk migration operations
- filesystem driver issues
- interrupted system updates

Enterprise administrators must understand how to rebuild initramfs safely to restore boot functionality.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Recovery Tool | `dracut` |
| Initramfs Path | `/boot/initramfs-<kernel>.img` |
| Kernel Version | `5.14.x` |
| Bootloader | GRUB2 |

---

# Common Failure Symptoms

| Symptom | Description |
|---|---|
| Kernel panic during boot | Missing drivers in initramfs |
| Dracut emergency shell | Corrupted initramfs |
| Root filesystem not found | Storage module missing |
| Boot hangs | Failed early userspace initialization |
| Rescue mode required | Boot process failure |

---

# Verify Current Kernel

## Display Running Kernel

```bash
uname -r
```

---

# Verify Existing Initramfs Images

## List Initramfs Files

```bash
ls -lh /boot/initramfs*
```

---

# Backup Existing Initramfs

## Create Backup Copy

```bash
sudo cp \
/boot/initramfs-$(uname -r).img \
/boot/initramfs-$(uname -r).img.bak
```

---

# Rebuild Initramfs

## Rebuild Current Kernel Initramfs

```bash
sudo dracut -f
```

Expected output:

```text
dracut: Generating /boot/initramfs-<kernel>.img
```

---

# Rebuild Specific Kernel Initramfs

## Rebuild Initramfs For Selected Kernel

```bash
sudo dracut -f \
/boot/initramfs-5.14.x.img \
5.14.x
```

---

# Verify Rebuilt Image

## Verify New Initramfs Timestamp

```bash
ls -lh /boot/initramfs*
```

## Verify File Type

```bash
file /boot/initramfs-$(uname -r).img
```

---

# Validate Installed Drivers

## List Included Kernel Modules

```bash
lsinitrd /boot/initramfs-$(uname -r).img
```

## Verify Storage Drivers

```bash
lsinitrd | grep xfs
```

---

# Rebuild GRUB Configuration

## Generate Updated GRUB Configuration

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

---

# Reboot System

## Restart Server

```bash
sudo reboot
```

---

# Administrative Validation

## Verify Successful Boot

```bash
systemctl status
```

## Verify Running Kernel

```bash
uname -r
```

## Verify Mounted Root Filesystem

```bash
mount | grep " / "
```

## Verify Boot Logs

```bash
journalctl -b
```

---

# Logging Validation

## Review Dracut Logs

```bash
journalctl | grep dracut
```

## Review Failed Services

```bash
systemctl --failed
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| `dracut` fails | Missing disk space | Verify `/boot` capacity |
| System still fails to boot | Missing drivers | Rebuild with required modules |
| Wrong kernel image rebuilt | Incorrect kernel version | Verify using `uname -r` |
| GRUB not updated | Missing GRUB rebuild | Run `grub2-mkconfig` |

---

# Operational Quality Notes

This initramfs rebuild workflow reflects enterprise Linux recovery practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- initramfs image generation
- required storage drivers
- successful system boot
- GRUB configuration integrity
- mounted root filesystem
- kernel compatibility

Initramfs rebuild procedures should be tested regularly during kernel maintenance and disaster recovery exercises.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| Initramfs rebuild validation | `initramfs-rebuild-validation.png` |

---

# Screenshot Reference


![Initramfs Rebuild Validation](../screenshots/initramfs-rebuild-validation.png)
