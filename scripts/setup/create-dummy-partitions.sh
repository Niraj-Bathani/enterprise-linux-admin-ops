#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Dummy Partition Setup Script
# RHEL 9.6 Lab Environment Preparation
# --------------------------------------------------

LOG_FILE="/var/log/create-dummy-partitions.log"

DISK_DEVICE="/dev/sdb"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Dummy Partition Setup"
echo "--------------------------------------"

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Script must be run as root"
    exit 1
fi

# --------------------------------------------------
# Verify Target Disk Exists
# --------------------------------------------------

if [ ! -b "${DISK_DEVICE}" ]; then
    echo "$(date) ERROR: Disk device not found: ${DISK_DEVICE}" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Target disk detected: ${DISK_DEVICE}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Current Disk Layout
# --------------------------------------------------

lsblk ${DISK_DEVICE}

# --------------------------------------------------
# Create GPT Partition Table
# --------------------------------------------------

parted -s ${DISK_DEVICE} mklabel gpt

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to create GPT label" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: GPT partition table created" \
>> ${LOG_FILE}

# --------------------------------------------------
# Create Dummy Partitions
# --------------------------------------------------

parted -s ${DISK_DEVICE} mkpart primary xfs 1MiB 1024MiB

parted -s ${DISK_DEVICE} mkpart primary ext4 1024MiB 2048MiB

parted -s ${DISK_DEVICE} mkpart primary xfs 2048MiB 3072MiB

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to create partitions" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Dummy partitions created successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Reload Partition Table
# --------------------------------------------------

partprobe ${DISK_DEVICE}

sleep 2

# --------------------------------------------------
# Verify Partition Creation
# --------------------------------------------------

lsblk ${DISK_DEVICE}

fdisk -l ${DISK_DEVICE}

# --------------------------------------------------
# Create Filesystems
# --------------------------------------------------

mkfs.xfs ${DISK_DEVICE}1 -f

mkfs.ext4 ${DISK_DEVICE}2 -F

mkfs.xfs ${DISK_DEVICE}3 -f

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Filesystem creation failed" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Filesystems created successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Create Mount Points
# --------------------------------------------------

mkdir -p /mnt/lab-xfs-01
mkdir -p /mnt/lab-ext4-01
mkdir -p /mnt/lab-xfs-02

# --------------------------------------------------
# Mount Partitions
# --------------------------------------------------

mount ${DISK_DEVICE}1 /mnt/lab-xfs-01

mount ${DISK_DEVICE}2 /mnt/lab-ext4-01

mount ${DISK_DEVICE}3 /mnt/lab-xfs-02

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to mount partitions" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Partitions mounted successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Verify Mounted Filesystems
# --------------------------------------------------

df -h | grep "/mnt/lab"

# --------------------------------------------------
# Display Final Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " Dummy Partition Setup Completed"
echo "--------------------------------------"

echo "Disk Device : ${DISK_DEVICE}"
echo "Mount Points:"
echo " - /mnt/lab-xfs-01"
echo " - /mnt/lab-ext4-01"
echo " - /mnt/lab-xfs-02"
echo "Log File    : ${LOG_FILE}"

echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
