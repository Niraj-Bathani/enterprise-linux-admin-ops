# RAID5 Parity Configuration

## Overview

This lab demonstrates enterprise Linux RAID5 configuration using `mdadm` on RHEL 9 systems.

The workflow simulates production storage deployments requiring balanced performance, redundancy, and efficient storage utilization for enterprise workloads.

---

# Objective

This exercise covers:

- RAID5 array creation
- parity-based redundancy
- filesystem configuration
- persistent RAID setup
- degraded array simulation
- RAID rebuild operations
- enterprise RAID operational practices

---

# Environment Information

| Item | Details |
|---|---|
| Operating System | RHEL 9.6 |
| Hostname | rhel9-storage01.prod.lab |
| RAID Type | RAID5 |
| RAID Device | /dev/md0 |
| RAID Utility | mdadm |
| Filesystem | XFS |
| SELinux | Enforcing |

---

# RAID5 Overview

RAID5 provides:

- parity-based redundancy
- balanced read performance
- improved storage efficiency
- fault tolerance for one disk failure

RAID5 characteristics:

- minimum three disks required
- distributed parity blocks
- slower write performance than RAID10
- rebuild operations consume high I/O

---

# Planned RAID Layout

| Device | Purpose |
|---|---|
| /dev/sdb1 | RAID Member |
| /dev/sdc1 | RAID Member |
| /dev/sdd1 | RAID Member |
| /dev/md0 | RAID5 Array |
| /raid5-data | Mount Point |

---

# Initial Disk Validation

## Verify Available Storage Devices

```bash
lsblk
```

Expected output:

```text
sdb
sdc
sdd
```

---

# Partition Preparation

## Create RAID Partitions

Prepare all disks:

```bash
fdisk /dev/sdb
fdisk /dev/sdc
fdisk /dev/sdd
```

Partition requirements:

- create primary partition
- allocate full disk size
- set partition type to `fd` (Linux RAID)

---

## Verify Partition Layout

```bash
lsblk
```

Expected output:

```text
sdb1
sdc1
sdd1
```

---

# RAID5 Array Creation

## Create RAID5 Array

```bash
mdadm --create --verbose /dev/md0 \
--level=5 \
--raid-devices=3 \
/dev/sdb1 /dev/sdc1 /dev/sdd1
```

Expected output:

```text
mdadm: array /dev/md0 started.
```

---

## Verify RAID Status

```bash
cat /proc/mdstat
```

Expected output:

```text
md0 : active raid5
```

---

## Verify RAID Details

```bash
mdadm --detail /dev/md0
```

Expected output:

```text
Raid Level : raid5
```

---

# RAID Synchronization Validation

## Monitor Synchronization

```bash
watch cat /proc/mdstat
```

Expected output:

```text
recovery = 63.4%
```

---

## Verify Synchronization Completion

```bash
cat /proc/mdstat
```

Expected output:

```text
[UUU]
```

RAID5 synchronization completed successfully.

---

# Filesystem Creation

## Create XFS Filesystem

```bash
mkfs.xfs /dev/md0
```

Expected output:

```text
meta-data=/dev/md0
```

---

## Verify Filesystem

```bash
blkid /dev/md0
```

Expected output:

```text
TYPE="xfs"
```

---

# Mount Configuration

## Create Mount Point

```bash
mkdir -p /raid5-data
```

---

## Mount RAID5 Filesystem

```bash
mount /dev/md0 /raid5-data
```

---

## Verify Mounted Filesystem

```bash
df -hT | grep raid5-data
```

Expected output:

```text
/dev/md0 xfs
```

---

# Persistent RAID Configuration

## Save RAID Metadata

```bash
mdadm --detail --scan >> /etc/mdadm.conf
```

---

## Verify mdadm Configuration

```bash
cat /etc/mdadm.conf
```

Expected output:

```text
ARRAY /dev/md0
```

---

# Persistent Filesystem Mount

## Retrieve Filesystem UUID

```bash
blkid /dev/md0
```

---

## Configure /etc/fstab

```bash
vi /etc/fstab
```

Add:

```text
UUID=<uuid> /raid5-data xfs defaults 0 0
```

---

## Validate fstab Configuration

```bash
mount -a
```

No output indicates successful validation.

---

# Filesystem Validation

## Verify Read/Write Operations

```bash
touch /raid5-data/raid5-test.txt
```

---

## Verify File Creation

```bash
ls -l /raid5-data
```

Expected output:

```text
raid5-test.txt
```

---

# RAID Failure Simulation

## Simulate Single Disk Failure

```bash
mdadm /dev/md0 --fail /dev/sdc1
```

---

## Remove Failed Disk

```bash
mdadm /dev/md0 --remove /dev/sdc1
```

---

## Verify Degraded RAID Status

```bash
cat /proc/mdstat
```

Expected output:

```text
[UU_]
```

RAID5 remains operational during single disk failure.

---

# RAID Recovery Validation

## Add Replacement Disk

```bash
mdadm /dev/md0 --add /dev/sdc1
```

---

## Monitor RAID Rebuild

```bash
watch cat /proc/mdstat
```

Expected output:

```text
recovery = 81.7%
```

---

## Verify Final RAID Status

```bash
cat /proc/mdstat
```

Expected output:

```text
[UUU]
```

---

# Disk Health Validation

## Verify SMART Status

```bash
smartctl -H /dev/sdb
smartctl -H /dev/sdc
smartctl -H /dev/sdd
```

Expected output:

```text
PASSED
```

---

# RAID Monitoring Validation

## Verify mdmonitor Service

```bash
systemctl status mdmonitor
```

Expected output:

```text
active (running)
```

---

# Performance Validation

## Verify RAID I/O Statistics

```bash
iostat -xz 1 1
```

Expected output:

```text
parity disk performance statistics
```

---

# SELinux Validation

## Verify SELinux Status

```bash
getenforce
```

Expected output:

```text
Enforcing
```

SELinux remains enabled throughout all RAID operations.

---

# Operational Recommendations

## Use RAID5 for Balanced Storage Efficiency

Recommended workloads:

- file servers
- backup repositories
- archive storage
- general-purpose enterprise storage

Avoid RAID5 for:

- extremely write-heavy databases
- ultra-low-latency transactional systems

---

## Monitor Rebuild Operations Carefully

RAID5 rebuilds generate:

- high disk utilization
- elevated latency
- increased failure risk during rebuild

Enterprise monitoring should validate:

- rebuild progress
- SMART disk health
- parity consistency
- degraded RAID conditions

---

## Replace Failed Disks Immediately

Operating degraded RAID5 arrays increases risk of:

- total array failure
- unrecoverable data loss
- parity corruption
- operational downtime

---

# Operational Notes

- RAID5 balances storage efficiency and redundancy
- RAID5 rebuilds are slower than RAID10
- parity calculations increase write overhead
- mdadm metadata should be persisted
- enterprise monitoring is critical during rebuild operations

---

# Expected Outcome

After completing this lab:

- RAID5 array is operational
- parity redundancy is validated
- degraded array recovery is verified
- enterprise RAID monitoring practices are reviewed
- balanced redundant storage is configured

---

# Screenshot Reference

![Screenshot](../screenshots/04-raid5-parity.png)
