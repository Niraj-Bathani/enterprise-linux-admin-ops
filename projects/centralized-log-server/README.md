# Centralized Log Server

## Overview

This project demonstrates centralized logging implementation using rsyslog on RHEL 9.6 systems. The environment aggregates logs from multiple Linux servers into a dedicated logging server for centralized monitoring, troubleshooting, and operational visibility.

The implementation follows enterprise Linux operational standards with SELinux enforcing and firewalld enabled.

---

# Objective

In this project you will:

- Configure centralized rsyslog collection
- Enable remote log forwarding
- Configure TCP and UDP log reception
- Validate centralized logging workflows
- Monitor incoming system logs
- Verify log persistence
- Troubleshoot logging failures
- Validate enterprise operational monitoring

---

# Environment Information

| Hostname | Role | IP Address |
|---|---|---|
| log01.prod.lab | Centralized Log Server | 192.168.80.20 |
| web01.prod.lab | Client Web Server | 192.168.80.21 |
| app01.prod.lab | Client Application Server | 192.168.80.22 |

Environment details:

- Operating System: RHEL 9.6
- Logging Utility: rsyslog
- SELinux: Enforcing
- firewalld: Enabled
- Logging Protocols: TCP/UDP 514

---

# Initial Validation

Verify hostname configuration.

```bash
hostnamectl
```

Expected output:

```text
Static hostname: log01.prod.lab
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

Verify rsyslog package installation.

```bash
rpm -q rsyslog
```

Expected output:

```text
rsyslog
```

---

Verify rsyslog service state.

```bash
systemctl status rsyslog
```

Expected output:

```text
active (running)
```

---

# Configure Centralized Log Server

Edit rsyslog configuration.

```bash
vi /etc/rsyslog.conf
```

---

Enable UDP reception.

```text
module(load="imudp")
input(type="imudp" port="514")
```

---

Enable TCP reception.

```text
module(load="imtcp")
input(type="imtcp" port="514")
```

---

Create centralized log storage rule.

```text
$template RemoteLogs,"/var/log/remote/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
```

---

Create remote log directory.

```bash
mkdir -p /var/log/remote
```

---

Restart rsyslog service.

```bash
systemctl restart rsyslog
```

---

Verify listening ports.

```bash
ss -tulpn | grep 514
```

Expected output:

```text
udp
tcp
```

---

# Configure Firewall Access

Allow rsyslog traffic.

```bash
firewall-cmd --add-port=514/tcp --permanent
```

```bash
firewall-cmd --add-port=514/udp --permanent
```

---

Reload firewall configuration.

```bash
firewall-cmd --reload
```

Expected output:

```text
success
```

---

Verify firewall rules.

```bash
firewall-cmd --list-ports
```

Expected output:

```text
514/tcp
514/udp
```

---

# Configure Client Log Forwarding

Edit rsyslog client configuration.

```bash
vi /etc/rsyslog.d/remote.conf
```

---

Add centralized logging configuration.

```text
*.* @@192.168.80.20:514
```

---

Restart rsyslog service.

```bash
systemctl restart rsyslog
```

---

Verify rsyslog service state.

```bash
systemctl status rsyslog
```

Expected output:

```text
active (running)
```

---

# Generate Remote Logs

Generate test log message.

```bash
logger "centralized logging validation"
```

---

Generate authentication log entry.

```bash
su -
```

Expected output:

```text
Authentication failure
```

---

Generate custom application log.

```bash
logger -t app-validation "application logging test"
```

---

# Validate Centralized Logging

Verify remote log directories.

```bash
ls -R /var/log/remote
```

Expected output:

```text
web01.prod.lab
app01.prod.lab
```

---

Verify received logs.

```bash
tail -f /var/log/remote/web01.prod.lab/messages.log
```

Expected output:

```text
centralized logging validation
```

---

Verify application logs.

```bash
tail -f /var/log/remote/app01.prod.lab/app-validation.log
```

Expected output:

```text
application logging test
```

---

# Monitoring Validation

Monitor rsyslog service.

```bash
systemctl status rsyslog
```

---

Monitor active log connections.

```bash
ss -antp | grep 514
```

Expected output:

```text
ESTAB
```

---

Monitor remote log activity.

```bash
tail -f /var/log/remote/*/*.log
```

---

Monitor system resource usage.

```bash
top
```

Expected output:

```text
rsyslogd
```

---

# Logging Validation

Review rsyslog service logs.

```bash
journalctl -u rsyslog
```

Expected output:

```text
Started System Logging Service
```

---

Review recent system logs.

```bash
journalctl -n 20
```

Expected output:

```text
systemd
```

---

Review remote logging activity.

```bash
journalctl | grep rsyslog
```

Expected output:

```text
imtcp
imudp
```

---

# Troubleshooting

Verify listening ports.

```bash
ss -tulpn | grep 514
```

---

Verify firewall rules.

```bash
firewall-cmd --list-ports
```

---

Verify rsyslog syntax.

```bash
rsyslogd -N1
```

Expected output:

```text
End of config validation run
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

Verify remote log directories.

```bash
ls -lh /var/log/remote
```

---

# Persistence Validation

Reboot the centralized log server.

```bash
sudo reboot
```

---

Verify rsyslog service after reboot.

```bash
systemctl status rsyslog
```

Expected output:

```text
active (running)
```

---

Verify listening ports after reboot.

```bash
ss -tulpn | grep 514
```

Expected output:

```text
514/tcp
514/udp
```

---

Verify remote logging functionality.

```bash
logger "post reboot validation"
```

Expected output:

```text
No output
```

---

# Security Validation

Verify SELinux remains enforcing.

```bash
getenforce
```

Expected output:

```text
Enforcing
```

---

Verify firewall exposure.

```bash
firewall-cmd --list-ports
```

Expected output:

```text
514/tcp
514/udp
```

---

Verify rsyslog ownership.

```bash
ps -ef | grep rsyslog
```

Expected output:

```text
root
```

---

# Operational Recommendations

- Centralize logs for operational visibility
- Monitor rsyslog service continuously
- Archive historical logs regularly
- Restrict log server access carefully
- Validate remote forwarding after updates
- Monitor storage utilization continuously
- Implement log rotation policies
- Document operational recovery procedures

---

# Operational Notes

Centralized logging improves enterprise Linux troubleshooting, security monitoring, and operational visibility across infrastructure environments.

During troubleshooting validate:

- rsyslog service state
- Listening ports
- Firewall configuration
- Remote forwarding configuration
- Log storage permissions
- SELinux operational state
- Network connectivity

---

# Expected Outcome

After completing this project:

- Centralized logging functions correctly
- Remote log forwarding operates successfully
- TCP and UDP log collection function properly
- Monitoring and troubleshooting workflows operate correctly
- Log persistence functions successfully
- SELinux remains enforcing
- Enterprise operational logging workflows are validated

---

![Screenshot](../screenshots/centralized-log-server.png)
