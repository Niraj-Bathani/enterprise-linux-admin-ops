# HAProxy Configuration Templates

## Overview

This directory contains enterprise-style HAProxy configuration documentation used in the RHEL 9.6 Linux infrastructure lab environment.

The configurations demonstrate:

- load balancing
- backend pool management
- SSL termination
- reverse proxy operations
- backend health validation
- enterprise traffic distribution workflows

These documents are designed for:

- enterprise Linux administration
- infrastructure operations
- load balancer troubleshooting
- operational validation
- portfolio documentation

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Load Balancer | HAProxy |
| Frontend Server | `LB01` |
| Backend Servers | `WEB01`, `WEB02` |
| Backend Network | `192.168.100.0/24` |
| Service Name | `haproxy` |

---

# Configuration Files

| File | Purpose |
|---|---|
| `haproxy-main-configuration.md` | Main HAProxy frontend and backend configuration |
| `haproxy-backend-pool.md` | Backend pool management and health checks |
| `haproxy-ssl-termination.md` | HTTPS frontend and SSL termination configuration |

---

# Enterprise Operational Areas

The HAProxy configurations in this directory cover:

- HTTP load balancing
- backend health monitoring
- SSL/TLS termination
- frontend listener management
- reverse proxy operations
- firewall validation
- backend failover
- enterprise traffic distribution

---

# Administrative Validation Commands

## Validate HAProxy Configuration

```bash
haproxy -c -f /etc/haproxy/haproxy.cfg
```

## Verify HAProxy Service Status

```bash
systemctl status haproxy
```

## Verify Listening Ports

```bash
ss -tulpn | grep haproxy
```

## Validate Backend Connectivity

```bash
curl http://192.168.100.20
curl http://192.168.100.21
```

## Validate Load Balancer Access

```bash
curl http://192.168.100.30
```

## Verify Firewall Configuration

```bash
firewall-cmd --list-all
```

---

# Common Enterprise Troubleshooting Areas

| Area | Validation |
|---|---|
| HAProxy startup failure | Validate configuration syntax |
| Backend servers DOWN | Verify backend HTTP services |
| SSL certificate errors | Validate certificate file and expiration |
| Traffic distribution issues | Verify balancing algorithm |
| Connection refused | Validate firewall rules |
| SELinux denials | Review SELinux policies |

---

# Operational Quality Notes

These configurations are designed to simulate enterprise HAProxy deployment practices commonly used in RHEL 9.6 environments.

Enterprise administrators should always validate:

- frontend listener availability
- backend server health
- SSL certificate validity
- firewall accessibility
- service startup state
- traffic distribution behavior
- backend failover functionality
- operational logging visibility

Load balancing infrastructure should be monitored regularly for backend failures, abnormal response times, and unexpected traffic spikes.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| HAProxy main configuration validation | `haproxy-main-validation.png` |
| HAProxy backend pool validation | `haproxy-backend-pool-validation.png` |
| HAProxy SSL termination validation | `haproxy-ssl-termination-validation.png` |

---

# Screenshot References

![HAProxy Main Validation](../screenshots/haproxy-main-validation.png)


![HAProxy Backend Pool Validation](../screenshots/haproxy-backend-pool-validation.png)


![HAProxy SSL Termination Validation](../screenshots/haproxy-ssl-termination-validation.png)
