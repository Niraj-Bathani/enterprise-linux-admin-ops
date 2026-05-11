#!/bin/bash

# ==========================================================
# Enterprise RAID Status Validation Script
# Platform : RHEL 9
# Purpose  : Validate mdadm RAID health and filesystem status
# ==========================================================

echo "=================================================="
echo " Enterprise RAID Status Validation"
echo "=================================================="
echo

# ----------------------------------------------------------
# Block Device Validation
# ----------------------------------------------------------

echo "[+] Block Device Validation"
lsblk
echo

# ----------------------------------------------------------
# RAID Device Validation
# ----------------------------------------------------------

echo "[+] RAID Device Status"
cat /proc/mdstat
echo

# ----------------------------------------------------------
# mdadm Detail Validation
# ----------------------------------------------------------

echo "[+] RAID Array Details"

for raid in /dev/md*
do
    if [ -b "$raid" ]; then
        mdadm --detail "$raid"
        echo
    fi
done

# ----------------------------------------------------------
# Filesystem Validation
# ----------------------------------------------------------

echo "[+] Mounted RAID Filesystems"
mount | grep md
echo

echo "[+] Filesystem Usage"
df -hT | grep md
echo

# ----------------------------------------------------------
# RAID Synchronization Validation
# ----------------------------------------------------------

echo "[+] RAID Synchronization Status"

cat /proc/mdstat | grep -iE "recover|resync|rebuild"

echo

# ----------------------------------------------------------
# Filesystem Read/Write Validation
# ----------------------------------------------------------

MOUNT_POINTS=$(mount | grep md | awk '{print $3}')

for mountpoint in $MOUNT_POINTS
do
    echo "[+] Testing Filesystem Access on $mountpoint"

    touch "$mountpoint/raid-validation.txt"

    if [ -f "$mountpoint/raid-validation.txt" ]; then
        echo "PASS : Filesystem write validation successful"
    else
        echo "FAIL : Filesystem validation failed"
    fi

    rm -f "$mountpoint/raid-validation.txt"

    echo
done

# ----------------------------------------------------------
# RAID Disk Health Validation
# ----------------------------------------------------------

echo "[+] RAID Disk Health Validation"

for disk in /dev/sd[b-z]
do
    if [ -b "$disk" ]; then
        smartctl -H "$disk" | grep "SMART overall-health"
    fi
done

echo

# ----------------------------------------------------------
# RAID Event Counter Validation
# ----------------------------------------------------------

echo "[+] RAID Event Validation"

for raid in /dev/md*
do
    if [ -b "$raid" ]; then
        mdadm --detail "$raid" | grep Events
    fi
done

echo

# ----------------------------------------------------------
# Persistent RAID Configuration Validation
# ----------------------------------------------------------

echo "[+] mdadm Configuration Validation"

cat /etc/mdadm.conf

echo

# ----------------------------------------------------------
# RAID Service Validation
# ----------------------------------------------------------

echo "[+] RAID Monitoring Service Validation"

systemctl status mdmonitor --no-pager | grep Active

echo

# ----------------------------------------------------------
# SELinux Validation
# ----------------------------------------------------------

echo "[+] SELinux Status"

getenforce

echo

# ----------------------------------------------------------
# Performance Validation
# ----------------------------------------------------------

echo "[+] RAID Disk Performance Statistics"

iostat -xz 1 1

echo

# ----------------------------------------------------------
# Final Summary
# ----------------------------------------------------------

echo "=================================================="
echo " RAID Validation Completed"
echo "=================================================="
