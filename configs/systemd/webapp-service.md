# Web Application Systemd Service

## Objective

Create and manage a custom systemd service for a web application in a RHEL 9.6 enterprise Linux environment to support automated service management, startup persistence, and operational monitoring.

---

# Why It Matters

Custom systemd services are widely used in enterprise Linux environments for:

- application lifecycle management
- automated startup
- service monitoring
- operational consistency
- dependency management
- centralized process control

Systemd improves reliability and simplifies enterprise application administration.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Service Manager | `systemd` |
| Service Name | `webapp.service` |
| Application User | `webapp` |
| Application Path | `/opt/webapp` |
| Listening Port | `8080` |

---

# Create Application User

## Create Dedicated Service Account

```bash
sudo useradd -r -s /sbin/nologin webapp
```

## Verify User

```bash
id webapp
```

---

# Prepare Application Directory

## Create Application Path

```bash
sudo mkdir -p /opt/webapp
```

## Configure Ownership

```bash
sudo chown -R webapp:webapp /opt/webapp
```

## Create Example Startup Script

```bash
sudo vi /opt/webapp/start-webapp.sh
```

## Example Startup Script

```bash
#!/bin/bash

python3 -m http.server 8080
```

## Make Script Executable

```bash
sudo chmod +x /opt/webapp/start-webapp.sh
```

---

# Create Systemd Service File

## Create Service Unit

```bash
sudo vi /etc/systemd/system/webapp.service
```

## Example Service Configuration

```ini
[Unit]

Description=Custom Web Application Service

After=network.target

[Service]

Type=simple

User=webapp

WorkingDirectory=/opt/webapp

ExecStart=/opt/webapp/start-webapp.sh

Restart=always

RestartSec=5

[Install]

WantedBy=multi-user.target
```

---

# Reload Systemd Configuration

## Reload Daemon

```bash
sudo systemctl daemon-reload
```

## Enable Service

```bash
sudo systemctl enable webapp.service
```

## Start Service

```bash
sudo systemctl start webapp.service
```

---

# Administrative Validation

## Verify Service Status

```bash
systemctl status webapp.service
```

## Verify Listening Port

```bash
ss -tulpn | grep 8080
```

## Verify Running Process

```bash
ps -ef | grep webapp
```

## Test Web Application Access

```bash
curl http://localhost:8080
```

---

# Firewall Validation

## Allow Web Application Port

```bash
sudo firewall-cmd --permanent --add-port=8080/tcp
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

## Verify Port Context

```bash
sudo semanage port -l | grep 8080
```

---

# Logging Validation

## Review Service Logs

```bash
journalctl -u webapp.service
```

## Follow Live Logs

```bash
journalctl -fu webapp.service
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| Service fails to start | Invalid ExecStart path | Verify startup script |
| Port inaccessible | Firewall restriction | Allow TCP port 8080 |
| Service repeatedly restarts | Application crash | Review `journalctl` logs |
| Permission denied | Incorrect ownership | Verify application permissions |

---

# Operational Quality Notes

This systemd deployment reflects enterprise Linux application service management practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- service startup persistence
- process ownership
- application accessibility
- firewall exposure
- SELinux policy state
- service logging visibility

Custom services should be monitored regularly for restart failures, unexpected crashes, and resource usage anomalies.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| Web application service validation | `webapp-service-validation.png` |

---

# Screenshot Reference

![Web Application Service Validation](../screenshots/webapp-service-validation.png)
