# HAProxy Installation

## Overview

This lab installs and configures HAProxy on a RHEL 9.6 server for enterprise load balancing operations. The HAProxy node will distribute HTTP traffic across multiple Apache backend servers while performing backend health checks and frontend request handling.

The environment follows enterprise Linux operational practices using SELinux enforcing and firewalld enabled.

---

# Objective

In this lab you will:

- Install HAProxy packages
- Configure frontend listeners
- Configure backend server pools
- Configure health checks
- Configure firewalld access
- Validate service functionality
- Verify frontend and backend communication
- Validate persistence and operational monitoring

---

# Environment Information

| Hostname | Role | IP Address |
|---|---|---|
| rhel9-haproxy01.prod.lab | HAProxy Load Balancer | 192.168.10.10 |
| web01.prod.lab | Apache Backend Server | 192.168.10.101 |
| web02.prod.lab | Apache Backend Server | 192.168.10.102 |
| web03.prod.lab | Apache Backend Server | 192.168.10.103 |

Environment details:

- Operating System: RHEL 9.6
- SELinux: Enforcing
- firewalld: Enabled
- HAProxy Version: 2.x
- Frontend Port: 80/TCP

---

# Initial Validation

Verify hostname configuration.

```bash
hostnamectl
```

Expected output:

```text
 Static hostname: rhel9-haproxy01.prod.lab
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

Verify firewalld service state.

```bash
systemctl status firewalld
```

Expected output:

```text
active (running)
```

---

Verify backend server connectivity.

```bash
ping -c 4 web01.prod.lab
```

```bash
ping -c 4 web02.prod.lab
```

```bash
ping -c 4 web03.prod.lab
```

Expected output:

```text
64 bytes from 192.168.10.101
64 bytes from 192.168.10.102
64 bytes from 192.168.10.103
```

---

# Install HAProxy

Install HAProxy packages.

```bash
sudo dnf install haproxy -y
```

---

Verify package installation.

```bash
rpm -q haproxy
```

Expected output:

```text
haproxy-2.x
```

---

Verify HAProxy version.

```bash
haproxy -v
```

Expected output:

```text
HAProxy version 2.x
```

---

# Backup Default Configuration

Create a backup of the default configuration file.

```bash
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak
```

---

Verify backup file.

```bash
ls -l /etc/haproxy/
```

Expected output:

```text
haproxy.cfg
haproxy.cfg.bak
```

---

# Configure HAProxy

Edit the HAProxy configuration file.

```bash
sudo vi /etc/haproxy/haproxy.cfg
```

---

Replace the configuration with the following example.

```haproxy
global
    log         127.0.0.1 local2
    daemon

defaults
    mode                    http
    log                     global
    option                  httplog
    timeout connect         10s
    timeout client          30s
    timeout server          30s

frontend frontend_http
    bind *:80
    default_backend apache_backend

backend apache_backend
    balance roundrobin
    option httpchk GET /health.html

    server web01 192.168.10.101:80 check
    server web02 192.168.10.102:80 check
    server web03 192.168.10.103:80 check
```

---

# Validate Configuration Syntax

Verify HAProxy configuration syntax.

```bash
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
```

Expected output:

```text
Configuration file is valid
```

---

# Enable and Start HAProxy

Enable and start the HAProxy service.

```bash
sudo systemctl enable --now haproxy
```

---

Verify service state.

```bash
sudo systemctl status haproxy
```

Expected output:

```text
Active: active (running)
```

---

Verify frontend listener ports.

```bash
ss -tulpn | grep haproxy
```

Expected output:

```text
LISTEN 0      4096          *:80
```

---

# Configure Firewall Access

Allow HTTP traffic through firewalld.

```bash
sudo firewall-cmd --permanent --add-service=http
```

```bash
sudo firewall-cmd --reload
```

---

Verify firewall services.

```bash
sudo firewall-cmd --list-services
```

Expected output:

```text
cockpit dhcpv6-client http ssh
```

---

# Validate Frontend Connectivity

Test HAProxy frontend access locally.

```bash
curl http://localhost
```

Expected output:

```text
Backend Server: web01.prod.lab
```

---

Test frontend access remotely.

```bash
curl http://192.168.10.10
```

Expected output:

```text
Backend Server: web01.prod.lab
```

---

# Validate Load Balancing

Run multiple requests against HAProxy.

```bash
for i in {1..6}; do curl -s http://192.168.10.10; done
```

Expected output:

```text
Backend Server: web01.prod.lab
Backend Server: web02.prod.lab
Backend Server: web03.prod.lab
```

---

# Validate Backend Health Checks

Verify backend health pages.

```bash
curl http://web01.prod.lab/health.html
```

```bash
curl http://web02.prod.lab/health.html
```

```bash
curl http://web03.prod.lab/health.html
```

Expected output:

```text
web01 healthy
web02 healthy
web03 healthy
```

---

Verify backend ports.

```bash
nc -zv web01.prod.lab 80
```

```bash
nc -zv web02.prod.lab 80
```

```bash
nc -zv web03.prod.lab 80
```

Expected output:

```text
Connection succeeded
```

---

# Monitoring Validation

Monitor HAProxy service state.

```bash
systemctl status haproxy
```

---

Monitor active frontend connections.

```bash
ss -antp | grep :80
```

---

Monitor HAProxy processes.

```bash
ps -ef | grep haproxy
```

Expected output:

```text
haproxy  1320
haproxy  1321
```

---

Watch live backend responses.

```bash
watch -n 2 'curl -s http://192.168.10.10'
```

Expected output:

```text
Backend Server: web01.prod.lab
Backend Server: web02.prod.lab
Backend Server: web03.prod.lab
```

---

# Logging Validation

Monitor HAProxy logs.

```bash
sudo tail -f /var/log/haproxy.log
```

Expected output:

```text
Connect from 192.168.10.10
```

---

Review HAProxy journal logs.

```bash
sudo journalctl -u haproxy
```

---

# Troubleshooting

Validate HAProxy configuration syntax.

```bash
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
```

---

Restart HAProxy service.

```bash
sudo systemctl restart haproxy
```

---

Verify listener availability.

```bash
ss -tulpn | grep :80
```

---

Verify firewall rules.

```bash
sudo firewall-cmd --list-services
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

Reboot the HAProxy server.

```bash
sudo reboot
```

---

Verify service persistence after reboot.

```bash
systemctl status haproxy
```

Expected output:

```text
enabled
active (running)
```

---

Verify frontend availability after reboot.

```bash
curl http://192.168.10.10
```

Expected output:

```text
Backend Server: web01.prod.lab
```

---

# Security Validation

Verify only required services are exposed.

```bash
sudo firewall-cmd --list-services
```

---

Verify HAProxy configuration file permissions.

```bash
ls -l /etc/haproxy/haproxy.cfg
```

Expected output:

```text
-rw-r----- root root
```

---

Verify SELinux mode remains enforcing.

```bash
getenforce
```

Expected output:

```text
Enforcing
```

---

# Operational Recommendations

- Keep SELinux enabled in enforcing mode
- Validate HAProxy configuration before reloads
- Monitor backend health continuously
- Restrict unnecessary open ports
- Use HTTPS termination in production
- Maintain configuration backups
- Monitor frontend response times
- Centralize HAProxy logs

---

# Operational Notes

HAProxy distributes frontend requests across multiple backend servers using the configured balancing algorithm. Health checks automatically remove failed backend nodes from active rotation.

During troubleshooting validate:

- Frontend listener availability
- Backend server accessibility
- Firewall configuration
- SELinux contexts
- HAProxy configuration syntax
- Backend health check responses

---

# Expected Outcome

After completing this lab:

- HAProxy is installed and operational
- Frontend listener is accessible
- Backend servers are reachable
- Load balancing functions correctly
- Backend health checks operate correctly
- firewalld allows required traffic
- SELinux remains enforcing
- HAProxy service persists after reboot

---

![Screenshot](../screenshots/haproxy-install.png)
