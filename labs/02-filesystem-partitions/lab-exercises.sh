#!/bin/bash

# ==========================================================
# Filesystem and Partitioning Lab Exercises
# Platform : RHEL 9
# Purpose  : Enterprise storage administration practice
# ==========================================================

echo "=================================================="
echo " Filesystem and Partitioning Lab Exercises"
echo "=================================================="
echo

# ----------------------------------------------------------
# Disk Validation
# ----------------------------------------------------------

echo "[+] Available Block Devices"
lsblk
echo

# ----------------------------------------------------------
# Partition Validation
# ----------------------------------------------------------

echo "[+] Partition Table Information"
fdisk -l /dev/sdb
echo

# ----------------------------------------------------------
# Filesystem Type Validation
# ----------------------------------------------------------

echo "[+] Filesystem Identification"
blkid /dev/sdb1 /dev/sdb2
echo

# ----------------------------------------------------------
# EXT4 Filesystem Validation
# ----------------------------------------------------------

echo "[+] EXT4 Filesystem Details"
tune2fs -l /dev/sdb1 | head
echo

# ----------------------------------------------------------
# XFS Filesystem Validation
# ----------------------------------------------------------

echo "[+] XFS Filesystem Details"
xfs_info /data-xfs
echo

# ----------------------------------------------------------
# Mount Validation
# ----------------------------------------------------------

echo "[+] Mounted Filesystems"
mount | grep sdb
echo

echo "[+] Filesystem Usage"
df -hT | grep sdb
echo

# ----------------------------------------------------------
# Persistent Mount Validation
# ----------------------------------------------------------

echo "[+] Persistent Mount Configuration"
grep sdb /etc/fstab
echo

# ----------------------------------------------------------
# Read/Write Validation
# ----------------------------------------------------------

echo "[+] Filesystem Read/Write Validation"

touch /data-ext4/ext4-validation.txt
touch /data-xfs/xfs-validation.txt

if [ -f /data-ext4/ext4-validation.txt ]; then
    echo "PASS : EXT4 write validation successful"
else
    echo "FAIL : EXT4 write validation failed"
fi

if [ -f /data-xfs/xfs-validation.txt ]; then
    echo "PASS : XFS write validation successful"
else
    echo "FAIL : XFS write validation failed"
fi

echo

# ----------------------------------------------------------
# UUID Validation
# ----------------------------------------------------------

echo "[+] UUID Validation"
blkid | grep sdb
echo

# ----------------------------------------------------------
# SELinux Validation
# ----------------------------------------------------------

echo "[+] SELinux Status"
getenforce
echo

# ----------------------------------------------------------
# I/O Validation
# ----------------------------------------------------------

echo "[+] Disk I/O Statistics"
iostat -xz 1 1
echo

# ----------------------------------------------------------
# Filesystem Performance Validation
# ----------------------------------------------------------

echo "[+] Filesystem Synchronization Test"

sync

echo "Filesystem synchronization completed"
echo

# ----------------------------------------------------------
# Cleanup Validation Files
# ----------------------------------------------------------

echo "[+] Cleanup Validation Files"

rm -f /data-ext4/ext4-validation.txt
rm -f /data-xfs/xfs-validation.txt

echo "Temporary validation files removed"
echo

# ----------------------------------------------------------
# Final Summary
# ----------------------------------------------------------

echo "=================================================="
echo " Filesystem Lab Validation Completed"
echo "=================================================="
