#!/bin/bash

# ==========================================================
# Enterprise LVM Creation Script
# Platform : RHEL 9
# Purpose  : Create Physical Volume, Volume Group,
#            Logical Volume, Filesystem, and Mount Point
# ==========================================================

set -e

# ----------------------------------------------------------
# Variables
# ----------------------------------------------------------

DISK="/dev/sdb"
PARTITION="/dev/sdb1"

VG_NAME="vg_data"
LV_NAME="lv_appdata"

LV_SIZE="8G"

MOUNT_POINT="/app-data"

FILESYSTEM="xfs"

# ----------------------------------------------------------
# Initial Validation
# ----------------------------------------------------------

echo "=================================================="
echo " Enterprise LVM Provisioning"
echo "=================================================="
echo

echo "[+] Validating Block Devices"
lsblk
echo

# ----------------------------------------------------------
# Create Partition
# ----------------------------------------------------------

echo "[+] Creating LVM Partition"

parted -s ${DISK} mklabel gpt
parted -s ${DISK} mkpart primary 1MiB 100%
parted -s ${DISK} set 1 lvm on

echo

echo "[+] Reloading Partition Table"
partprobe ${DISK}
sleep 2

echo

echo "[+] Validating Partition Layout"
lsblk ${DISK}
echo

# ----------------------------------------------------------
# Create Physical Volume
# ----------------------------------------------------------

echo "[+] Creating Physical Volume"

pvcreate ${PARTITION}

echo

echo "[+] Physical Volume Validation"
pvs
echo

# ----------------------------------------------------------
# Create Volume Group
# ----------------------------------------------------------

echo "[+] Creating Volume Group"

vgcreate ${VG_NAME} ${PARTITION}

echo

echo "[+] Volume Group Validation"
vgs
echo

# ----------------------------------------------------------
# Create Logical Volume
# ----------------------------------------------------------

echo "[+] Creating Logical Volume"

lvcreate -L ${LV_SIZE} -n ${LV_NAME} ${VG_NAME}

echo

echo "[+] Logical Volume Validation"
lvs
echo

# ----------------------------------------------------------
# Create Filesystem
# ----------------------------------------------------------

echo "[+] Creating ${FILESYSTEM} Filesystem"

mkfs.${FILESYSTEM} /dev/${VG_NAME}/${LV_NAME}

echo

echo "[+] Filesystem Validation"
blkid /dev/${VG_NAME}/${LV_NAME}
echo

# ----------------------------------------------------------
# Create Mount Point
# ----------------------------------------------------------

echo "[+] Creating Mount Point"

mkdir -p ${MOUNT_POINT}

echo

# ----------------------------------------------------------
# Mount Logical Volume
# ----------------------------------------------------------

echo "[+] Mounting Logical Volume"

mount /dev/${VG_NAME}/${LV_NAME} ${MOUNT_POINT}

echo

echo "[+] Mounted Filesystem Validation"

df -hT | grep ${LV_NAME}

echo

# ----------------------------------------------------------
# Persistent Mount Configuration
# ----------------------------------------------------------

echo "[+] Configuring Persistent Mount"

UUID=$(blkid -s UUID -o value /dev/${VG_NAME}/${LV_NAME})

echo "UUID=${UUID} ${MOUNT_POINT} ${FILESYSTEM} defaults 0 0" >> /etc/fstab

echo

echo "[+] Validating fstab Configuration"

mount -a

echo

# ----------------------------------------------------------
# Read/Write Validation
# ----------------------------------------------------------

echo "[+] Filesystem Read/Write Validation"

touch ${MOUNT_POINT}/lvm-test-file.txt

if [ -f ${MOUNT_POINT}/lvm-test-file.txt ]; then
    echo "PASS : LVM filesystem operational"
else
    echo "FAIL : Filesystem validation failed"
fi

echo

# ----------------------------------------------------------
# SELinux Validation
# ----------------------------------------------------------

echo "[+] SELinux Status"

getenforce

echo

# ----------------------------------------------------------
# Final Summary
# ----------------------------------------------------------

echo "=================================================="
echo " LVM Provisioning Completed"
echo "=================================================="

echo
echo "Volume Group : ${VG_NAME}"
echo "Logical Volume : ${LV_NAME}"
echo "Mount Point : ${MOUNT_POINT}"
echo "Filesystem : ${FILESYSTEM}"
echo
