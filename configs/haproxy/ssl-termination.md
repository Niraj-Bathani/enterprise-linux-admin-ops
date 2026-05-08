# HAProxy SSL Termination Configuration

## Objective

Configure SSL termination on HAProxy in a RHEL 9.6 enterprise Linux environment to securely handle HTTPS traffic while forwarding decrypted requests to backend web servers.

---

# Why It Matters

SSL termination improves enterprise infrastructure operations by:

- centralizing TLS management
- reducing backend encryption overhead
- simplifying certificate administration
- improving load balancer visibility
- enabling secure client communication
- supporting scalable HTTPS deployments

Enterprise administrators commonly deploy SSL termination at the load balancer layer to simplify web infrastructure management.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Load Balancer | HAProxy |
| Frontend Server | `LB01` |
| Backend Servers | `WEB01`, `WEB02` |
| HTTPS Port | `443` |
| SSL Certificate Path | `/etc/haproxy/certs/lab.pem` |

---

# HAProxy SSL Termination Configuration

## Frontend HTTPS Listener

```haproxy
frontend https_front

    bind *:443 ssl crt /etc/haproxy/certs/lab.pem

    mode http

    option httplog

    default_backend web_backend
```

---

# Backend Pool Configuration

```haproxy
backend web_backend

    balance roundrobin

    option httpchk GET /

    server web01 192.168.100.20:80 check

    server web02 192.168.100.21:80 check
```

---

# SSL Certificate Preparation

## Create Certificate Directory

```bash
sudo mkdir -p /etc/haproxy/certs
```

## Generate Self-Signed Certificate

```bash
sudo openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 \
-keyout /etc/haproxy/certs/lab.key \
-out /etc/haproxy/certs/lab.crt
```

## Combine Certificate And Key

```bash
sudo bash -c 'cat /etc/haproxy/certs/lab.key \
/etc/haproxy/certs/lab.crt \
> /etc/haproxy/certs/lab.pem'
```

---

# Deployment Procedure

## Edit HAProxy Configuration

```bash
sudo vi /etc/haproxy/haproxy.cfg
```

## Validate HAProxy Configuration

```bash
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
```

## Restart HAProxy Service

```bash
sudo systemctl restart haproxy
```

---

# Firewall Validation

## Allow HTTPS Traffic

```bash
sudo firewall-cmd --add-service=https --permanent
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

## Verify HTTPS Port Context

```bash
sudo semanage port -l | grep http_port_t
```

---

# Verification

## Verify HAProxy HTTPS Listener

```bash
ss -tulpn | grep 443
```

## Validate HTTPS Access

```bash
curl -k https://192.168.100.30
```

## Verify Certificate Details

```bash
openssl x509 -in /etc/haproxy/certs/lab.crt -text -noout
```

## Verify HAProxy Service Status

```bash
systemctl status haproxy
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| HAProxy fails to start | Invalid certificate path | Verify certificate file |
| HTTPS connection refused | Firewall restriction | Allow HTTPS service |
| Certificate errors | Invalid or expired certificate | Regenerate certificate |
| Backend unavailable | Backend Apache failure | Verify backend services |

---

# Operational Quality Notes

This SSL termination configuration reflects enterprise load balancing and HTTPS deployment practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- certificate integrity
- HTTPS listener availability
- backend server reachability
- firewall accessibility
- TLS functionality
- certificate expiration dates

SSL certificates should be rotated regularly according to enterprise security policy.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| HAProxy SSL termination validation | `haproxy-ssl-termination-validation.png` |

---

# Screenshot Reference

![HAProxy SSL Termination Validation](../screenshots/haproxy-ssl-termination-validation.png)
