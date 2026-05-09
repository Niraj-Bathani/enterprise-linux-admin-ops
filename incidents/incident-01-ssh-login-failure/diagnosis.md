# Incident 01 — SSH Login Failure

## Overview

This document captures the diagnostic activities performed during an SSH authentication failure affecting administrative access to `rhel9-app01.prod.corp.local`.

The incident impacted Linux administrators and infrastructure automation workflows within the production environment.

---

# Incident Summary

| Item | Details |
|---|---|
| Incident ID | INC-RHEL-SSH-2026-001 |
| Severity | SEV-2 |
| Environment | Production |
| Affected Host | rhel9-app01.prod.corp.local |
| Operating System | RHEL 9.6 |
| Service Impacted | sshd |
| Detection Time | 2026-05-08 09:14 UTC |
| Status | Resolved |

---

# Symptoms

Observed symptoms during the incident:

- SSH authentication failures for valid domain accounts
- Ansible connectivity failures from automation controllers
- Repeated PAM-related authentication errors in journald
- Delayed administrative access to the affected server

Example client-side error:

```text
adminops@rhel9-app01.prod.corp.local: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password)
```

---

# Initial Validation

## Verify Host Reachability

```bash
ping -c 4 rhel9-app01.prod.corp.local
```

Output:

```text
64 bytes from 10.40.18.25: icmp_seq=1 ttl=64 time=0.512 ms
64 bytes from 10.40.18.25: icmp_seq=2 ttl=64 time=0.495 ms
64 bytes from 10.40.18.25: icmp_seq=3 ttl=64 time=0.507 ms
64 bytes from 10.40.18.25: icmp_seq=4 ttl=64 time=0.491 ms
```

Network connectivity to the host was confirmed.

---

## Verify SSH Port Availability

```bash
nc -zv rhel9-app01.prod.corp.local 22
```

Output:

```text
Connection to rhel9-app01.prod.corp.local 22 port [tcp/ssh] succeeded!
```

SSH service port accessibility was validated successfully.

---

# Service Validation

## Verify sshd Service Status

```bash
systemctl status sshd
```

Output:

```text
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled)
     Active: active (running) since Thu 2026-05-08 08:42:11 UTC
   Main PID: 911 (sshd)
```

The SSH daemon was operational during the investigation.

---

# Log Analysis

## Review SSH Authentication Logs

```bash
journalctl -u sshd -n 20 --no-pager
```

Output:

```text
May 08 09:11:03 rhel9-app01 sshd[3251]: pam_sss(sshd:auth): authentication failure
May 08 09:11:05 rhel9-app01 sshd[3251]: Failed password for adminops from 10.40.12.14 port 52412 ssh2
May 08 09:11:06 rhel9-app01 sshd[3251]: fatal: Access denied for user adminops by PAM account configuration
May 08 09:11:42 rhel9-app01 sshd[3260]: pam_sss(sshd:account): Access denied for user adminops
```

The logs indicated authentication failures originating from the PAM/SSSD authentication layer.

---

# Authentication Stack Validation

## Verify SSSD Service Status

```bash
systemctl status sssd
```

Output:

```text
● sssd.service - System Security Services Daemon
     Loaded: loaded (/usr/lib/systemd/system/sssd.service; enabled)
     Active: active (running)
```

SSSD service was functioning normally.

---

## Verify Domain Integration

```bash
realm list
```

Output:

```text
corp.local
  type: kerberos
  realm-name: CORP.LOCAL
  configured: kerberos-member
  client-software: sssd
```

The system remained properly joined to the enterprise domain.

---

## Verify LDAP User Resolution

```bash
id adminops
```

Output:

```text
uid=201145(adminops) gid=201145(domain users) groups=201145(domain users),201210(linux-admins)
```

LDAP identity resolution completed successfully.

---

# Configuration Validation

## Validate SSH Configuration

```bash
sshd -t
```

No SSH configuration syntax errors were detected.

---

## Review PAM Configuration

```bash
grep -v '^#' /etc/pam.d/sshd
```

Output:

```text
auth       substack     password-auth
account    required     pam_nologin.so
account    include      password-auth
session    required     pam_selinux.so close
session    include      password-auth
```

PAM configuration matched the enterprise authentication baseline.

---

# SELinux Validation

## Verify SELinux Status

```bash
getenforce
```

Output:

```text
Enforcing
```

SELinux remained enabled in enforcing mode.

---

## Review SELinux Denials

```bash
ausearch -m AVC -ts recent
```

Output:

```text
<no matches>
```

No SELinux policy denials related to SSH authentication were identified.

---

# Investigation Findings

The investigation isolated the issue to the enterprise authentication authorization layer.

Key findings:

- Network connectivity was operational
- SSH service was running normally
- SSH port accessibility was confirmed
- SSH configuration validation passed successfully
- SSSD service remained operational
- LDAP identity resolution succeeded
- PAM account validation was rejecting authorized users
- No SELinux or firewall-related issues were identified

The evidence indicated an authentication authorization policy issue rather than a network or service availability failure.

---

# Operational Impact

- Administrative SSH access was interrupted
- Ansible automation jobs failed against the affected host
- Scheduled maintenance activities were delayed
- Manual operational intervention was required

---

# Screenshot Reference

| Screenshot | Description |
|---|---|
| incident-01-diagnosis.png | Enterprise Linux troubleshooting session showing SSH authentication failures, PAM/SSSD diagnostics, journald log analysis, and sshd service validation |

---
# Screenshot Reference

![SSH Login Failure Diagnosis](../../screenshots/incident-01-diagnosis.png)
