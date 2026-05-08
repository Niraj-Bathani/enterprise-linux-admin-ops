# SSH Hardening Configuration

## Objective

Harden the OpenSSH server configuration in a RHEL 9.6 enterprise Linux environment to reduce attack surface, improve authentication security, and align with enterprise Linux security administration practices.

---

# Why It Matters

SSH hardening is critical in enterprise Linux environments because SSH is commonly targeted by:

- brute-force attacks
- credential theft
- unauthorized remote access
- automated scanning activity
- password spraying
- privilege escalation attempts

Enterprise administrators use SSH hardening to improve remote access security and reduce exposure to common attack techniques.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| SSH Service | `sshd` |
| Configuration File | `/etc/ssh/sshd_config` |
| Management Network | `192.168.100.0/24` |
| SSH Port | `22` |

---

# Enterprise SSH Hardening Configuration

## Edit SSH Configuration File

```bash
sudo vi /etc/ssh/sshd_config
```

## Recommended Hardening Settings

```text
Port 22

PermitRootLogin no

PasswordAuthentication no

PubkeyAuthentication yes

PermitEmptyPasswords no

MaxAuthTries 3

LoginGraceTime 30

ClientAliveInterval 300

ClientAliveCountMax 2

AllowUsers sysadmin

X11Forwarding no

AllowTcpForwarding no

Banner /etc/issue.net
```

---

# SSH Key Authentication

## Generate SSH Key Pair

```bash
ssh-keygen -t rsa -b 4096
```

## Copy Public Key To Server

```bash
ssh-copy-id sysadmin@192.168.100.10
```

## Test Key-Based Login

```bash
ssh sysadmin@192.168.100.10
```

---

# Validate SSH Configuration

## Verify SSHD Syntax

```bash
sudo sshd -t
```

## Restart SSH Service

```bash
sudo systemctl restart sshd
```

## Verify SSH Service Status

```bash
systemctl status sshd
```

---

# Firewall Validation

## Allow SSH Service

```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

## Verify Firewall Rules

```bash
sudo firewall-cmd --list-all
```

---

# SELinux Validation

## Verify SELinux Mode

```bash
getenforce
```

## Verify SSH Port Context

```bash
sudo semanage port -l | grep ssh
```

---

# Log Validation

## Monitor SSH Authentication Logs

```bash
sudo journalctl -u sshd
```

## Review Failed Login Attempts

```bash
sudo grep "Failed password" /var/log/secure
```

## Review Accepted Logins

```bash
sudo grep "Accepted" /var/log/secure
```

---

# Administrative Validation

## Verify Listening SSH Port

```bash
ss -tulpn | grep sshd
```

## Verify Active Sessions

```bash
who
```

## Verify SSH Key Authentication

```bash
ssh -v sysadmin@192.168.100.10
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| SSH login denied | Incorrect key permissions | Validate `.ssh` directory permissions |
| SSHD restart failure | Invalid syntax | Run `sshd -t` |
| SSH blocked | Firewall restriction | Allow SSH service |
| Public key authentication fails | Missing authorized key | Verify `authorized_keys` |

---

# Operational Quality Notes

This SSH hardening configuration reflects enterprise Linux security administration practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- disabled root login
- SSH key authentication
- firewall accessibility
- restricted administrator access
- authentication logging
- active SSH sessions

SSH authentication logs should be reviewed regularly for:

- brute-force attempts
- unauthorized login attempts
- unexpected source IPs
- abnormal login behavior

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| SSH hardening validation | `ssh-hardening-validation.png` |

---

# Screenshot Reference

![SSH Hardening Validation](../screenshots/ssh-hardening-validation.png)
