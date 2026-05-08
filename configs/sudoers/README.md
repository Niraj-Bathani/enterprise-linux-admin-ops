# Sudoers Configuration Templates

## Overview

This directory contains enterprise-style sudoers configuration documentation used in the RHEL 9.6 Linux infrastructure lab environment.

The configurations demonstrate:

- privilege delegation
- least-privilege access control
- operational role separation
- helpdesk administrative policies
- backup operator permissions
- enterprise sudo validation workflows

These documents are designed for:

- enterprise Linux administration
- operational security management
- access control validation
- infrastructure troubleshooting
- portfolio documentation

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Sudo Framework | `sudo` |
| Validation Tool | `visudo` |
| Sudoers File | `/etc/sudoers` |
| Include Directory | `/etc/sudoers.d/` |

---

# Configuration Files

| File | Purpose |
|---|---|
| `custom-sudoers-entry.md` | Custom sudo privilege delegation |
| `helpdesk-sudo-policy.md` | Restricted helpdesk operational access |
| `backup-operator-policy.md` | Backup operator command delegation |

---

# Enterprise Operational Areas

The sudoers configurations in this directory cover:

- least-privilege administration
- role-based access control
- command-level privilege delegation
- operational separation of duties
- sudo logging and auditing
- restricted administrative access
- enterprise Linux operational security
- sudoers validation workflows

---

# Administrative Validation Commands

## Validate Sudoers Syntax

```bash
visudo -c
```

## Validate Sudoers Include Files

```bash
visudo -cf /etc/sudoers.d/<policy-file>
```

## Verify User Sudo Permissions

```bash
sudo -l
```

## Review Sudo Logs

```bash
journalctl | grep sudo
```

## Review Secure Log Entries

```bash
grep sudo /var/log/secure
```

## Verify Sudoers File Permissions

```bash
ls -l /etc/sudoers.d/
```

---

# Common Enterprise Troubleshooting Areas

| Area | Validation |
|---|---|
| Sudo access denied | Verify sudoers entry |
| Syntax errors | Validate using `visudo` |
| User missing permissions | Verify group membership |
| Unauthorized command execution | Restrict sudoers rules |
| Missing sudo logs | Verify journald and secure logs |
| Incorrect include permissions | Validate file ownership and mode |

---

# Operational Quality Notes

These configurations are designed to simulate enterprise Linux privilege delegation practices commonly used in RHEL 9.6 environments.

Enterprise administrators should always validate:

- least-privilege enforcement
- command restriction scope
- sudo logging visibility
- administrative accountability
- sudoers syntax integrity
- include file permissions
- role-based access control
- operational security compliance

Administrative privileges should be reviewed regularly to prevent privilege creep and reduce operational risk.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| Custom sudoers validation | `custom-sudoers-validation.png` |
| Helpdesk sudo policy validation | `helpdesk-sudo-policy-validation.png` |
| Backup operator policy validation | `backup-operator-policy-validation.png` |

---

# Screenshot References


![Custom Sudoers Validation](../screenshots/custom-sudoers-validation.png)


![Helpdesk Sudo Policy Validation](../screenshots/helpdesk-sudo-policy-validation.png)


![Backup Operator Policy Validation](../screenshots/backup-operator-policy-validation.png)
