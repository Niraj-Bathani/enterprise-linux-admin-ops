# Systemd Backup Timer Configuration

## Objective

Configure and validate a systemd timer in a RHEL 9.6 enterprise Linux environment to automate recurring backup operations using native systemd scheduling capabilities.

---

# Why It Matters

Systemd timers are widely used in enterprise Linux environments for:

- scheduled backups
- automated maintenance
- recurring operational tasks
- centralized scheduling
- service automation
- infrastructure reliability

Systemd timers provide a modern alternative to traditional cron-based scheduling.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Service Manager | `systemd` |
| Timer Name | `backup.timer` |
| Service Name | `my-backup.service` |
| Backup Directory | `/backup` |
| Schedule | Every 30 minutes |

---

# Prerequisites

This timer depends on the following service:

```text
my-backup.service
```

The service should already exist and successfully execute backup operations.

---

# Create Timer Unit File

## Create Timer File

```bash
sudo vi /etc/systemd/system/backup.timer
```

## Example Timer Configuration

```ini
[Unit]

Description=Run Backup Service Every 30 Minutes

[Timer]

OnBootSec=5min

OnUnitActiveSec=30min

Unit=my-backup.service

[Install]

WantedBy=timers.target
```

---

# Reload Systemd Configuration

## Reload Daemon

```bash
sudo systemctl daemon-reload
```

## Enable Timer

```bash
sudo systemctl enable backup.timer
```

## Start Timer

```bash
sudo systemctl start backup.timer
```

---

# Administrative Validation

## Verify Timer Status

```bash
systemctl status backup.timer
```

## List Active Timers

```bash
systemctl list-timers
```

## Verify Timer Details

```bash
systemctl cat backup.timer
```

## Verify Associated Service

```bash
systemctl status my-backup.service
```

---

# Backup Validation

## Verify Backup Archive Creation

```bash
ls -lh /backup
```

## Verify Multiple Backup Files

```bash
ls -l /backup | wc -l
```

## Validate Recent Backup Timestamps

```bash
ls -ltr /backup
```

---

# Logging Validation

## Review Timer Logs

```bash
journalctl -u backup.timer
```

## Review Backup Service Logs

```bash
journalctl -u my-backup.service
```

## Follow Live Logs

```bash
journalctl -fu my-backup.service
```

---

# SELinux Validation

## Verify SELinux Mode

```bash
getenforce
```

## Verify Backup Directory Context

```bash
ls -Zd /backup
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| Timer not running | Timer not enabled | Enable timer |
| Service never executes | Incorrect Unit value | Verify `Unit=` directive |
| Backup files missing | Backup service failure | Review service logs |
| Timer not visible | Daemon not reloaded | Run `systemctl daemon-reload` |

---

# Operational Quality Notes

This timer deployment reflects enterprise Linux operational automation practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- timer execution frequency
- backup archive generation
- logging visibility
- service execution state
- timer persistence after reboot
- backup retention management

Automated operational jobs should be monitored regularly to detect scheduling failures and missed executions.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| Backup timer validation | `backup-timer-validation.png` |

---

# Screenshot Reference

![Backup Timer Validation](../screenshots/backup-timer-validation.png)
