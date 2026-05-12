# Enterprise Linux Administration Operations Lab

## Overview

The Enterprise Linux Administration Operations Lab is a structured hands-on learning environment designed for practicing enterprise Linux system administration, troubleshooting, monitoring, automation, recovery, networking, and operational workflows on RHEL 9.6 systems.

This repository focuses on real-world operational tasks commonly performed by Linux administrators, infrastructure engineers, site reliability engineers, DevOps engineers, and operations teams in enterprise environments.

The labs emphasize:

- Practical administration workflows
- Operational troubleshooting
- Performance monitoring
- Service management
- Enterprise networking
- Security hardening
- Automation scripting
- Incident response
- Recovery procedures
- Root cause analysis

---

# Repository Structure

```text
enterprise-linux-operations-lab/
├── fundamentals/
├── storage-management/
├── networking/
├── services/
├── security/
├── automation/
├── monitoring/
├── troubleshooting/
├── projects/
├── scripts/
├── screenshots/
├── glossary.md
├── resources.md
└── README.md
```

---

# Learning Objectives

After completing this repository you will be able to:

- Manage enterprise Linux systems confidently
- Troubleshoot operational incidents
- Analyze performance bottlenecks
- Configure enterprise services
- Automate administrative workflows
- Secure Linux infrastructure
- Recover failed systems
- Analyze logs and monitoring data
- Perform root cause analysis
- Operate production-style Linux environments

---

# Environment Information

| Component | Details |
|---|---|
| Operating System | RHEL 9.6 |
| Shell | Bash |
| Init System | systemd |
| Firewall | firewalld |
| SELinux | Enforcing |
| Logging | journald + rsyslog |
| Networking Tools | ss, tcpdump, nmcli |
| Monitoring Tools | sar, top, vmstat |
| Troubleshooting Tools | strace, lsof, tcpdump |

---

# Lab Categories

## Linux Fundamentals

Core Linux administration tasks:

- File management
- User administration
- Permissions
- Process management
- Package management
- Service control
- Scheduling jobs
- Shell operations

---

## Storage Management

Enterprise storage operations:

- Partitioning
- LVM management
- Filesystem creation
- Mount operations
- RAID troubleshooting
- Backup workflows
- Recovery procedures

---

## Networking

Linux networking administration:

- Interface configuration
- Routing
- DNS troubleshooting
- SSH management
- Firewall operations
- Packet capture analysis
- Network troubleshooting

---

## Service Management

Enterprise service operations:

- Apache
- MariaDB
- HAProxy
- SSH
- systemd
- Logging services
- Monitoring services

---

## Security Operations

Linux security workflows:

- SELinux management
- SSH hardening
- Firewall restrictions
- Authentication analysis
- Log auditing
- Security validation

---

## Monitoring and Troubleshooting

Operational diagnostics:

- CPU monitoring
- Memory analysis
- Disk I/O monitoring
- Log analysis
- Root cause analysis
- Network troubleshooting
- System call tracing

---

## Automation and Scripting

Operational automation:

- Bash scripting
- Backup automation
- Monitoring scripts
- Health checks
- Reporting automation
- Recovery automation

---

# Example Operational Workflows

Examples included in the repository:

```bash
systemctl status httpd
journalctl -u sshd
tcpdump port 80
strace -p PID
lsof -i :22
sar -u 1 5
firewall-cmd --list-services
```

---

# Included Enterprise Projects

Projects included:

- Automated backup system
- Centralized log server
- Highly available web platform
- Multi-tier Linux application
- Secure SSH bastion host

---

# Screenshots and Visual References

The repository includes:

- Operational screenshots
- Troubleshooting diagrams
- Monitoring references
- Enterprise workflow visuals
- Command reference graphics
- Cheatsheets

---

# Recommended Usage

Recommended workflow:

```text
1. Read the lab objective
2. Configure the environment
3. Execute commands manually
4. Validate operational output
5. Troubleshoot failures
6. Document findings
7. Repeat workflows until consistent
```

---

# Skills Practiced

This repository develops practical experience with:

- Enterprise Linux operations
- Production troubleshooting
- Infrastructure monitoring
- Incident response
- Recovery validation
- Automation workflows
- Service administration
- Operational diagnostics

---

# Troubleshooting Philosophy

The labs follow a structured operational approach:

```text
Observation
    ↓
Evidence Collection
    ↓
Hypothesis Formation
    ↓
Validation
    ↓
Root Cause Analysis
    ↓
Recovery Validation
```

---

# Operational Recommendations

- Practice commands manually first
- Preserve troubleshooting evidence
- Avoid random configuration changes
- Validate one change at a time
- Use logs and monitoring tools consistently
- Document operational findings
- Practice recovery workflows repeatedly
- Treat labs like production systems

---

# Intended Audience

This repository is useful for:

- Linux administrators
- DevOps engineers
- Site reliability engineers
- Infrastructure engineers
- SOC analysts
- Support engineers
- Students preparing for RHCSA/RHCE
- Enterprise operations teams

---

# Expected Outcome

After completing this repository:

- Linux administration skills improve significantly
- Troubleshooting becomes structured
- Operational confidence increases
- Enterprise workflows become familiar
- Monitoring and recovery skills improve
- Production Linux operations become easier to manage

---

# Screenshots

```text
screenshots/
```

Contains:

- Operational terminal screenshots
- Monitoring dashboards
- Troubleshooting references
- Enterprise architecture visuals
- Workflow diagrams

---

# Notes

This repository is designed for educational and operational practice purposes using realistic enterprise Linux administration workflows.

All examples assume:

- RHEL 9.6
- SELinux enforcing
- firewalld enabled
- systemd-based systems

