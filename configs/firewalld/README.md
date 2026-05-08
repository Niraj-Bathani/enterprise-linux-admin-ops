# firewalld Configuration Templates

## Overview

This directory contains enterprise-style firewalld configuration documentation used in the RHEL 9.6 Linux infrastructure lab environment.

The configurations demonstrate:

- public zone management
- internal zone segmentation
- rich rule deployment
- source-based filtering
- service access control
- enterprise firewall validation workflows

These documents are designed for:

- enterprise Linux administration
- infrastructure security operations
- firewall troubleshooting
- operational validation
- portfolio documentation

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| Firewall Service | `firewalld` |
| Firewall Backend | `nftables` |
| Network Interface | `ens33` |
| Service Manager | `systemd` |

---

# Configuration Files

| File | Purpose |
|---|---|
| `public-zone.md` | Public zone service exposure and validation |
| `internal-zone.md` | Trusted internal network segmentation |
| `rich-rule-examples.md` | Advanced source-based firewall policies |

---

# Enterprise Operational Areas

The firewalld configurations in this directory cover:

- network segmentation
- service filtering
- administrative access control
- firewall logging
- internal network protection
- trusted source restrictions
- enterprise firewall management
- operational validation workflows

---

# Administrative Validation Commands

## Verify firewalld Status

```bash
systemctl status firewalld
```

## View Active Zones

```bash
firewall-cmd --get-active-zones
```

## View Zone Configuration

```bash
firewall-cmd --list-all
```

## View Rich Rules

```bash
firewall-cmd --list-rich-rules
```

## Verify Listening Services

```bash
ss -tulpn
```

## Reload firewalld

```bash
firewall-cmd --reload
```

---

# Common Enterprise Troubleshooting Areas

| Area | Validation |
|---|---|
| Service unreachable | Verify zone service rules |
| SSH blocked | Validate rich rules and source restrictions |
| Rules missing after reboot | Verify permanent configuration |
| Incorrect interface mapping | Review active zone assignments |
| NFS connectivity failure | Validate internal zone access |
| Logging not visible | Review `journalctl` output |

---

# Operational Quality Notes

These configurations are designed to simulate enterprise Linux firewall administration practices commonly used in production environments.

Enterprise administrators should always validate:

- zone assignments
- firewall persistence
- service exposure
- source restrictions
- internal network access
- firewall logging visibility
- listening ports
- service accessibility

Firewall modifications should always be tested from trusted client systems before production deployment.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| firewalld public zone validation | `firewalld-public-zone-validation.png` |
| firewalld internal zone validation | `firewalld-internal-zone-validation.png` |
| firewalld rich rule validation | `firewalld-rich-rule-validation.png` |

---

# Screenshot References

![firewalld Public Zone Validation](../screenshots/firewalld-public-zone-validation.png)


![firewalld Internal Zone Validation](../screenshots/firewalld-internal-zone-validation.png)


![firewalld Rich Rule Validation](../screenshots/firewalld-rich-rule-validation.png)
