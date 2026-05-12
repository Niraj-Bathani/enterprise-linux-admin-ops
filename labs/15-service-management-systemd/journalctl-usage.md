# journalctl Usage

## Overview

This lab demonstrates enterprise Linux logging and troubleshooting workflows using `journalctl` on RHEL 9.6 systems. The exercise covers viewing system logs, filtering logs by services and boot sessions, monitoring live journal entries, and troubleshooting operational issues using systemd journal management.

The workflow follows realistic enterprise Linux operational practices using systemd-journald with SELinux enforcing and firewalld enabled.

---

# Objective

In this lab you will:

- View system journal logs
- Filter logs by service
- View boot-specific logs
- Monitor live journal activity
- Search logs by priority level
- Troubleshoot service issues
- Validate persistent logging
- Verify journal management operations

---

# Environment Information

| Hostname | Role | IP Address |
|---|---|---|
| rhel9-systemd01.prod.lab | systemd Management Server | 192.168.30.10 |

Environment details:

- Operating System: RHEL 9.6
- Init System: systemd
- SELinux: Enforcing
- firewalld: Enabled
- Logging Service: systemd-journald

---

# Initial Validation

Verify hostname configuration.

```bash
hostnamectl
```

Expected output:

```text
 Static hostname: rhel9-systemd01.prod.lab
```

---

Verify journald service state.

```bash
systemctl status systemd-journald
```

Expected output:

```text
Active: active (running)
```

---

Verify current boot information.

```bash
who -b
```

Expected output:

```text
system boot
```

---

Verify SELinux mode.

```bash
getenforce
```

Expected output:

```text
Enforcing
```

---

# View Basic Journal Logs

Display recent journal entries.

```bash
journalctl -n 20
```

Expected output:

```text
systemd[1]:
```

---

View logs from the current boot.

```bash
journalctl -b
```

Expected output:

```text
Logs begin at
```

---

View logs in reverse order.

```bash
journalctl -r
```

---

View logs without paging.

```bash
journalctl --no-pager
```

---

# Filter Logs by Service

View logs for SSH service.

```bash
journalctl -u sshd
```

Expected output:

```text
Started OpenSSH server daemon
```

---

View logs for firewalld.

```bash
journalctl -u firewalld
```

Expected output:

```text
Started firewalld
```

---

View logs for NetworkManager.

```bash
journalctl -u NetworkManager
```

Expected output:

```text
NetworkManager
```

---

# Monitor Live Journal Logs

Monitor live journal activity.

```bash
journalctl -f
```

Expected output:

```text
live log updates
```

---

Monitor live SSH logs.

```bash
journalctl -fu sshd
```

Expected output:

```text
Accepted password
```

---

Generate a test log entry.

```bash
logger "journalctl validation test message"
```

---

Verify the new log entry.

```bash
journalctl | grep validation
```

Expected output:

```text
journalctl validation test message
```

---

# Filter Logs by Priority

View critical log entries.

```bash
journalctl -p crit
```

---

View error-level logs.

```bash
journalctl -p err
```

Expected output:

```text
error
```

---

View warning messages.

```bash
journalctl -p warning
```

---

View logs by priority range.

```bash
journalctl -p warning..crit
```

---

# Filter Logs by Time

View logs from the last hour.

```bash
journalctl --since "1 hour ago"
```

---

View logs from today.

```bash
journalctl --since today
```

---

View logs between time ranges.

```bash
journalctl --since "2026-05-12 09:00:00" --until "2026-05-12 10:00:00"
```

---

# Boot Log Validation

Display available boot sessions.

```bash
journalctl --list-boots
```

Expected output:

```text
0
-1
```

---

View logs from previous boot.

```bash
journalctl -b -1
```

Expected output:

```text
Logs begin at
```

---

View kernel logs.

```bash
journalctl -k
```

Expected output:

```text
kernel:
```

---

# Monitoring Validation

Monitor journal disk usage.

```bash
journalctl --disk-usage
```

Expected output:

```text
Archived and active journals
```

---

Monitor failed services.

```bash
systemctl --failed
```

Expected output:

```text
0 loaded units listed
```

---

Monitor authentication logs.

```bash
journalctl | grep sshd
```

---

Monitor live system activity.

```bash
journalctl -f
```

---

# Logging Validation

Verify persistent journal storage.

```bash
ls -ld /var/log/journal
```

Expected output:

```text
drwxr-sr-x
```

---

Verify journal files.

```bash
ls -lh /var/log/journal
```

Expected output:

```text
system.journal
```

---

Verify recent logs.

```bash
journalctl -n 10
```

---

Review service startup logs.

```bash
journalctl | grep Started
```

---

# Troubleshooting

Verify journald service state.

```bash
systemctl status systemd-journald
```

---

Restart journald service.

```bash
sudo systemctl restart systemd-journald
```

---

Verify journal integrity.

```bash
journalctl --verify
```

Expected output:

```text
PASS
```

---

Vacuum old logs by size.

```bash
sudo journalctl --vacuum-size=200M
```

---

Vacuum logs older than specific days.

```bash
sudo journalctl --vacuum-time=7d
```

---

Verify SELinux mode.

```bash
getenforce
```

Expected output:

```text
Enforcing
```

---

# Persistence Validation

Reboot the server.

```bash
sudo reboot
```

---

Verify journal persistence after reboot.

```bash
journalctl -b
```

Expected output:

```text
Logs begin at
```

---

Verify previous boot logs remain accessible.

```bash
journalctl -b -1
```

Expected output:

```text
Logs begin at
```

---

# Security Validation

Verify journal file permissions.

```bash
ls -ld /var/log/journal
```

Expected output:

```text
drwxr-sr-x
```

---

Verify SELinux remains enforcing.

```bash
getenforce
```

Expected output:

```text
Enforcing
```

---

Verify journal access restrictions.

```bash
journalctl --user
```

---

# Operational Recommendations

- Enable persistent journald storage
- Monitor journal disk usage regularly
- Centralize logs for enterprise environments
- Rotate old journal logs periodically
- Restrict unauthorized journal access
- Monitor failed service logs continuously
- Validate journald integrity regularly
- Archive critical operational logs

---

# Operational Notes

The `journalctl` utility provides centralized access to systemd journal logs and supports advanced filtering for troubleshooting enterprise Linux systems.

During troubleshooting validate:

- journald service state
- Log persistence
- Service-specific logs
- Boot logs
- Kernel logs
- Journal integrity
- Disk usage

---

# Expected Outcome

After completing this lab:

- Journal logs are accessible
- Service log filtering functions correctly
- Live log monitoring operates successfully
- Boot-specific logs are available
- Journal persistence works correctly
- Troubleshooting workflows function properly
- SELinux remains enforcing

---

![Screenshot](../screenshots/journalctl-usage.png)
