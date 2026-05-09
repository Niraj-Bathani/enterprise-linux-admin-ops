# vm-lab-setup.md

# VM Lab Setup and Virtual Infrastructure Cheat Sheet

## Overview

This document provides a practical enterprise Linux administration cheat sheet for virtual machine lab setup, VMware deployment preparation, network configuration, resource allocation, snapshot management, and operational validation on Red Hat Enterprise Linux (RHEL) 9.6 systems.

The commands and workflows included are commonly used during enterprise lab deployments, infrastructure testing, virtualization onboarding, training environments, and operational maintenance activities.

This reference is designed for fast operational lookup during production Linux administration tasks.

---

## Environment Information

| Component | Details |
|---|---|
| Operating System | RHEL 9.6 |
| Virtualization Platform | VMware Workstation / ESXi |
| Hostname | rhel01.lab.local |
| Virtual CPU | 4 vCPU |
| Virtual Memory | 8 GB |
| Virtual Disk | 60 GB Thin Provisioned |
| Network Mode | Bridged / NAT |
| User Context | root / sudo administrator |

---

## Common Commands

### Display Virtual Hardware Information

```bash
hostnamectl
```

### Display CPU Information

```bash
lscpu
```

### Display Memory Information

```bash
free -h
```

### Display Disk Layout

```bash
lsblk
```

### Display Network Interfaces

```bash
ip addr show
```

### Verify VMware Virtualization

```bash
systemd-detect-virt
```

### Display Active Network Connections

```bash
nmcli connection show
```

### Verify Internet Connectivity

```bash
ping -c 4 8.8.8.8
```

### Install VMware Tools (open-vm-tools)

```bash
dnf install -y open-vm-tools
```

### Enable VMware Tools Service

```bash
systemctl enable --now vmtoolsd
```

### Display Mounted Filesystems

```bash
df -Th
```

### Verify Time Synchronization

```bash
timedatectl
```

---

## Administrative Examples

### Validate Virtual Machine Environment

```bash
systemd-detect-virt
hostnamectl
```

### Configure Static Lab Network

```bash
nmcli connection modify ens160 \
ipv4.addresses 192.168.10.20/24 \
ipv4.gateway 192.168.10.1 \
ipv4.method manual
```

### Apply Network Configuration

```bash
nmcli connection down ens160
nmcli connection up ens160
```

### Install VMware Integration Tools

```bash
dnf install -y open-vm-tools
systemctl enable --now vmtoolsd
```

### Validate Storage Allocation

```bash
lsblk
df -Th
```

### Configure Hostname for Lab Systems

```bash
hostnamectl set-hostname rhel01.lab.local
```

### Verify Network Connectivity

```bash
ping -c 4 google.com
```

### Create Snapshot Preparation Checklist

```bash
systemctl --failed
journalctl -p err -b
```

---

## Validation Commands

### Verify Virtualization Platform

```bash
systemd-detect-virt
```

Example output:

```text
vmware
```

### Validate CPU and Memory Allocation

```bash
lscpu
free -h
```

### Verify Disk Provisioning

```bash
lsblk
```

### Validate Active Network Interfaces

```bash
ip addr show
```

### Verify VMware Tools Service State

```bash
systemctl status vmtoolsd
```

### Validate Time Synchronization

```bash
timedatectl
```

### Verify Hostname Configuration

```bash
hostnamectl
```

### Review Boot Logs

```bash
journalctl -b
```

---

## Troubleshooting Tips

### VM Network Connectivity Failure

Verify interface configuration:

```bash
ip addr show
```

Verify routing:

```bash
ip route
```

### VMware Tools Not Running

Verify service state:

```bash
systemctl status vmtoolsd
```

Restart VMware tools:

```bash
systemctl restart vmtoolsd
```

### Incorrect Resource Allocation

Verify CPU and memory:

```bash
lscpu
free -h
```

### Time Synchronization Problems

Verify time status:

```bash
timedatectl
```

Enable chrony:

```bash
systemctl enable --now chronyd
```

### Storage Space Issues

Review filesystem usage:

```bash
df -h
```

Review disk layout:

```bash
lsblk
```

### Snapshot or Boot Problems

Review system logs:

```bash
journalctl -b
```

Review failed services:

```bash
systemctl --failed
```

---

## Operational Notes

- Use snapshots before major configuration changes in lab environments.
- Maintain consistent VM naming and network configuration standards.
- Install VMware tools for improved guest integration and performance.
- Validate resource allocation before running enterprise workloads.
- Use bridged networking for realistic infrastructure simulations.
- Monitor disk utilization in thin-provisioned environments.
- Review logs and failed services before snapshot creation.

Example operational audit commands:

```bash
systemd-detect-virt
lsblk
hostnamectl
```

---

## Screenshot Reference

![Validation Screenshot](../screenshots/vm-lab-setup.png)


