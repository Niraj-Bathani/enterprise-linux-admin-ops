# Apache Configuration Templates

## Overview

This directory contains enterprise-style Apache HTTP Server configuration documentation used in the RHEL 9.6 Linux infrastructure lab environment.

The configurations demonstrate:

- Apache hardening
- reverse proxy deployments
- WordPress virtual host hosting
- operational validation workflows
- SELinux-aware web deployments
- enterprise Linux administration practices

These documents are designed for:

- enterprise Linux operations
- infrastructure troubleshooting
- configuration validation
- system administration practice
- portfolio documentation

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Web Server | Apache HTTP Server |
| Service Name | `httpd` |
| Firewall Service | `firewalld` |
| SELinux Mode | Enforcing |

---

# Configuration Files

| File | Purpose |
|---|---|
| `apache-hardening.md` | Apache security hardening procedures and validation |
| `apache-reverse-proxy.md` | Reverse proxy deployment and backend forwarding |
| `apache-wordpress-vhost.md` | WordPress virtual host deployment and validation |

---

# Enterprise Operational Areas

The Apache configurations in this directory cover:

- secure web server deployment
- reverse proxy configuration
- application publishing
- firewall validation
- SELinux troubleshooting
- DNS validation
- service monitoring
- operational verification

---

# Administrative Validation Commands

## Validate Apache Configuration

```bash
apachectl configtest
```

## Verify Apache Service Status

```bash
systemctl status httpd
```

## Verify Listening Ports

```bash
ss -tulpn | grep httpd
```

## Validate HTTP Access

```bash
curl http://localhost
```

## Verify Firewall Configuration

```bash
firewall-cmd --list-all
```

## Verify SELinux Mode

```bash
getenforce
```

---

# Common Enterprise Troubleshooting Areas

| Area | Validation |
|---|---|
| Apache startup failure | `apachectl configtest` |
| Firewall restrictions | `firewall-cmd --list-all` |
| SELinux denials | `ausearch -m AVC` |
| Reverse proxy failure | Backend connectivity validation |
| DNS resolution issues | `ping` and `/etc/hosts` validation |
| Permission issues | Ownership and SELinux context checks |

---

# Operational Quality Notes

These Apache configurations are intended to simulate enterprise Linux administration workflows commonly used in production environments.

Administrators should always validate:

- Apache syntax integrity
- service startup state
- firewall accessibility
- SELinux permissions
- backend connectivity
- virtual host resolution
- application availability
- log generation and monitoring

Configuration changes should be tested in a controlled environment before production deployment.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| Apache hardening validation | `apache-hardening-validation.png` |
| Apache reverse proxy validation | `apache-reverse-proxy-validation.png` |
| Apache WordPress virtual host validation | `apache-wordpress-vhost-validation.png` |

---

# Screenshot References


![Apache Hardening Validation](../screenshots/apache-hardening-validation.png)


![Apache Reverse Proxy Validation](../screenshots/apache-reverse-proxy-validation.png)


![Apache WordPress Virtual Host Validation](../screenshots/apache-wordpress-vhost-validation.png)
