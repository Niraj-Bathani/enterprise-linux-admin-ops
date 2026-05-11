#!/bin/bash

# ==========================================================
# Enterprise LVM Extension Script
# Platform : RHEL 9
# Purpose  : Extend Logical Volume and Filesystem
# ==========================================================

set -e

# ----------------------------------------------------------
# Variables
# ----------------------------------------------------------

VG_NAME="vg_data"
LV_NAME="lv_appdata"

LV_PATH="/dev/${VG_NAME}/${LV_NAME}"

EXTEND_SIZE="+4G"

MOUNT_POINT="/app-data"

FILESYSTEM_TYPE="xfs"

# ----------------------------------------------------------
# Initial Validation
# ----------------------------------------------------------

echo "=================================================="
echo " Enterprise LVM Extension"
echo "=================================================="
echo

echo "[+] Current Logical Volume Information"

lvs
echo

echo "[+] Current Filesystem Usage"

df -hT | grep ${LV_NAME}

echo

# ----------------------------------------------------------
# Validate Volume Group Free Space
# ----------------------------------------------------------

echo "[+] Volume Group Free Space Validation"

vgs

echo

VG_FREE=$(vgs --noheadings -o vg_free --units G ${VG_NAME} | tr -d ' ' | cut -d. -f1)

if [ "${VG_FREE}" -lt 4 ]; then
    echo "FAIL : Insufficient free space available in ${VG_NAME}"
    exit 1
fi

echo "PASS : Sufficient free space available"

echo

# ----------------------------------------------------------
# Extend Logical Volume
# ----------------------------------------------------------

echo "[+] Extending Logical Volume"

lvextend -L ${EXTEND_SIZE} ${LV_PATH}

echo

echo "[+] Logical Volume Validation"

lvs

echo

# ----------------------------------------------------------
# Extend Filesystem
# ----------------------------------------------------------

if [ "${FILESYSTEM_TYPE}" == "xfs" ]; then

    echo "[+] Extending XFS Filesystem"

    xfs_growfs ${MOUNT_POINT}

elif [ "${FILESYSTEM_TYPE}" == "ext4" ]; then

    echo "[+] Extending EXT4 Filesystem"

    resize2fs ${LV_PATH}

else

    echo "FAIL : Unsupported filesystem type"
    exit 1

fi

echo

# ----------------------------------------------------------
# Filesystem Validation
# ----------------------------------------------------------

echo "[+] Filesystem Usage Validation"

df -hT | grep ${LV_NAME}

echo

# ----------------------------------------------------------
# Filesystem Integrity Validation
# ----------------------------------------------------------

echo "[+] Filesystem Validation"

mount | grep ${LV_NAME}

echo

# ----------------------------------------------------------
# Read/Write Validation
# ----------------------------------------------------------

echo "[+] Filesystem Read/Write Validation"

touch ${MOUNT_POINT}/lv-extension-test.txt

if [ -f ${MOUNT_POINT}/lv-extension-test.txt ]; then
    echo "PASS : Logical volume extension successful"
else
    echo "FAIL : Filesystem validation failed"
fi

echo

# ----------------------------------------------------------
# Performance Validation
# ----------------------------------------------------------

echo "[+] Disk Usage Statistics"

iostat -xz 1 1

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
echo " Logical Volume Extension Completed"
echo "=================================================="

echo
echo "Volume Group : ${VG_NAME}"
echo "Logical Volume : ${LV_NAME}"
echo "Extended Size : ${EXTEND_SIZE}"
echo "Mount Point : ${MOUNT_POINT}"
echo
