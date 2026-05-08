# Root Password Reset Procedure

## Objective

Reset the root account password in a RHEL 9.6 enterprise Linux environment using GRUB emergency boot recovery procedures.

---

# Why It Matters

Enterprise Linux administrators may need to reset the root password due to:

- forgotten administrator credentials
- emergency access recovery
- inherited infrastructure systems
- account lockout situations
- operational recovery workflows
- security incident response

Controlled root password recovery is an essential enterprise Linux administration skill.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Bootloader | GRUB2 |
| Recovery Method | GRUB kernel edit |
| Authentication Target | `root` |
| Filesystem | XFS |

---

# Common Recovery Scenarios

| Scenario | Description |
|---|---|
| Forgotten root password | Administrator cannot authenticate |
| Expired credentials | Root access unavailable |
| Emergency recovery | Immediate privileged access required |
| Administrative lockout | Incorrect PAM or policy configuration |
| Infrastructure takeover | Credentials unavailable from previous administrator |

---

# Access GRUB Boot Menu

## Reboot System

Restart the system.

---

## Interrupt GRUB Boot Screen

At the GRUB menu press:

```text
e
```

to edit boot parameters.

---

# Modify Kernel Parameters

## Locate Linux Kernel Line

Find the line beginning with:

```text
linux
```

---

## Append Recovery Parameters

Add the following to the end of the line:

```text
rd.break
```

Example:

```text
linux ... ro rhgb quiet rd.break
```

---

# Boot Into Emergency Shell

## Boot With Modified Parameters

Press:

```text
Ctrl + X
```

or

```text
F10
```

---

# Remount Root Filesystem

## Remount Root Filesystem As Read-Write

```bash
mount -o remount,rw /sysroot
```

---

# Access Installed System

## Change Root Into Installed Environment

```bash
chroot /sysroot
```

---

# Reset Root Password

## Set New Root Password

```bash
passwd root
```

Expected output:

```text
passwd: all authentication tokens updated successfully.
```

---

# Relabel SELinux Contexts

## Create SELinux Relabel Trigger

```bash
touch /.autorelabel
```

This step is required to avoid SELinux authentication issues after reboot.

---

# Exit Recovery Environment

## Exit Chroot

```bash
exit
```

## Exit Emergency Shell

```bash
exit
```

---

# Reboot System

## Restart Server

```bash
reboot
```

The system will automatically relabel SELinux contexts during boot.

---

# Administrative Validation

## Verify Root Login

```bash
su -
```

## Verify SELinux Mode

```bash
getenforce
```

## Verify Successful Authentication

```bash
whoami
```

Expected output:

```text
root
```

---

# Logging Validation

## Review Authentication Logs

```bash
journalctl -b
```

## Review Failed Login Attempts

```bash
grep "Failed password" /var/log/secure
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| Password reset fails | Root filesystem read-only | Remount using `mount -o remount,rw` |
| Cannot authenticate after reboot | SELinux contexts incorrect | Run `touch /.autorelabel` |
| GRUB menu not accessible | Fast boot timing issue | Hold `Shift` during boot |
| Emergency shell unavailable | Incorrect kernel parameters | Verify `rd.break` |

---

# Operational Quality Notes

This root password recovery workflow reflects enterprise Linux emergency recovery practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- successful root authentication
- SELinux context integrity
- boot stability
- password policy compliance
- authentication logging visibility
- secure credential handling

Emergency credential recovery procedures should be restricted to authorized infrastructure administrators only.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| Root password reset validation | `root-password-reset-validation.png` |

---

# Screenshot Reference


![Root Password Reset Validation](../screenshots/root-password-reset-validation.png)
