# Initramfs Rebuild

## Recovery Objective

Initramfs Rebuild teaches controlled recovery from boot or early system startup problems. Boot recovery is high risk because an incorrect command can make a system harder to reach. Practice only in a VM with a current snapshot, and keep console access available. Do not perform boot loader writes on production systems without a tested backup and maintenance window.

## Concepts

A Linux boot path usually includes firmware, a boot loader, a kernel, an initramfs image, the root filesystem, and systemd. UEFI systems store boot entries in firmware and files under the EFI system partition. BIOS or MBR systems rely on boot code in the disk layout. initramfs problems often appear after storage, driver, encryption, or LVM changes.

## Commands

```bash
efibootmgr -v
grub2-mkconfig -o /boot/grub2/grub.cfg
dracut -f
lsinitrd /boot/initramfs-$(uname -r).img | head
journalctl -b -1 -p warning
```

## Method

Identify where the boot stops before changing anything. Firmware errors, GRUB prompts, initramfs emergency shells, and systemd rescue targets all point to different layers. Mount filesystems read/write only after you know which device is root. Rebuild GRUB or initramfs from a chroot when needed, then verify paths carefully before rebooting.

## Validation

A recovery is successful when the system boots twice, reaches the expected target, mounts all required filesystems, and records no unexplained boot errors in `journalctl -b`. Document the exact symptom, the failed layer, the fix, and the command output that proved the machine was healthy again.

## Operator Notes

Treat Initramfs Rebuild as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
