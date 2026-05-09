# post-install-hardening.md

# Post-Install Hardening Cheat Sheet

## Overview

This document provides a practical enterprise Linux administration cheat sheet for post-installation hardening, security baseline configuration, access control validation, system protection, and operational security tasks on Red Hat Enterprise Linux (RHEL) 9.6 systems.

The commands and workflows included are commonly used during enterprise server provisioning, compliance preparation, infrastructure hardening, audit readiness, and operational maintenance activities.

This reference is designed for fast operational lookup during production Linux administration tasks.

---

## Environment Information

| Component | Details |
|---|---|
| Operating System | RHEL 9.6 |
| Hostname | rhel01.lab.local |
| Security Framework | SELinux |
| Firewall Service | firewalld |
| Logging Service | rsyslog |
| Authentication | OpenSSH |
| User Context | root / sudo administrator |
| Lab Platform | VMware Enterprise Lab |

---

## Common Commands

### Update Installed Packages

```bash
dnf update -y
```

### Verify SELinux Status

```bash
sestatus
```

### Enable Firewall Service

```bash
systemctl enable --now firewalld
```

### Display Active Firewall Rules

```bash
firewall-cmd --list-all
```

### Disable Root SSH Login

```bash
vim /etc/ssh/sshd_config
```

### Restart SSH Service

```bash
systemctl restart sshd
```

### Review Active Services

```bash
systemctl list-units --type=service --state=running
```

### Remove Unnecessary Packages

```bash
dnf remove telnet ftp
```

### Verify Listening Network Ports

```bash
ss -tulpn
```

### Install Security Audit Tools

```bash
dnf install -y lynis audit
```

### Enable Auditd Service

```bash
systemctl enable --now auditd
```

### Review Authentication Logs

```bash
journalctl -u sshd
```

---

## Administrative Examples

### Apply System Updates

```bash
dnf update -y
```

### Configure SELinux Enforcing Mode

```bash
setenforce 1
```

Persistent configuration:

```conf
SELINUX=enforcing
```

### Harden SSH Configuration

Edit SSH daemon configuration:

```bash
vim /etc/ssh/sshd_config
```

Recommended settings:

```conf
PermitRootLogin no
PasswordAuthentication no
Protocol 2
```

### Configure Firewall Rules

```bash
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload
```

### Remove Legacy Insecure Services

```bash
dnf remove telnet-server rsh-server ypbind
```

### Install Security Auditing Tools

```bash
dnf install -y lynis fail2ban audit
```

### Verify Running Services

```bash
systemctl list-units --type=service --state=running
```

### Review Open Network Ports

```bash
ss -tulpn
```

---

## Validation Commands

### Verify SELinux Mode

```bash
getenforce
```

Example output:

```text
Enforcing
```

### Validate Firewall Status

```bash
systemctl status firewalld
```

### Verify Active Firewall Rules

```bash
firewall-cmd --list-all
```

### Validate SSH Configuration Syntax

```bash
sshd -t
```

### Verify Auditd Service State

```bash
systemctl status auditd
```

### Review Listening Network Ports

```bash
ss -tulpn
```

### Validate Installed Security Packages

```bash
rpm -qa | grep -E 'audit|lynis|fail2ban'
```

### Review Authentication and Security Logs

```bash
journalctl -xe
```

---

## Troubleshooting Tips

### SSH Access Failures After Hardening

Validate SSH configuration:

```bash
sshd -t
```

Review SSH logs:

```bash
journalctl -u sshd
```

### Firewall Blocking Required Services

Review active rules:

```bash
firewall-cmd --list-all
```

Add missing service:

```bash
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
```

### SELinux Access Denials

Review AVC denials:

```bash
ausearch -m avc -ts recent
```

Generate troubleshooting report:

```bash
sealert -a /var/log/audit/audit.log
```

### Unnecessary Services Running

Review active services:

```bash
systemctl list-units --type=service --state=running
```

Disable unused service:

```bash
systemctl disable --now cups
```

### Excessive Open Ports

Review listening ports:

```bash
ss -tulpn
```

### Security Audit Warnings

Run Lynis security scan:

```bash
lynis audit system
```

---

## Operational Notes

- Apply security hardening immediately after enterprise deployments.
- Keep SELinux enabled in enforcing mode.
- Disable unused services and remove legacy packages.
- Restrict SSH access using keys and hardened configurations.
- Review open ports and firewall rules regularly.
- Integrate auditd and centralized logging into enterprise monitoring.
- Validate system hardening after updates and configuration changes.

Example operational audit commands:

```bash
sestatus
firewall-cmd --list-all
ss -tulpn
```

---

## Screenshot Reference

![Validation Screenshot](../screenshots/post-install-hardening.p
