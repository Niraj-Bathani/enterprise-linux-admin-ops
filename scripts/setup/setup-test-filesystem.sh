#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Test Filesystem Setup Script
# RHEL 9.6 Lab Environment Preparation
# --------------------------------------------------

LOG_FILE="/var/log/setup-test-filesystem.log"

TEST_DISK="/dev/sdc"
MOUNT_POINT="/mnt/test-filesystem"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Test Filesystem Setup"
echo "--------------------------------------"

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Script must be run as root"
    exit 1
fi

# --------------------------------------------------
# Verify Target Disk
# --------------------------------------------------

if [ ! -b "${TEST_DISK}" ]; then
    echo "$(date) ERROR: Disk device not found: ${TEST_DISK}" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Target disk detected: ${TEST_DISK}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Existing Disk Layout
# --------------------------------------------------

lsblk ${TEST_DISK}

# --------------------------------------------------
# Create GPT Partition Table
# --------------------------------------------------

parted -s ${TEST_DISK} mklabel gpt

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to create GPT partition table" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: GPT partition table created successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Create Primary Partition
# --------------------------------------------------

parted -s ${TEST_DISK} mkpart primary xfs 1MiB 100%

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to create primary partition" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Primary partition created successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Reload Partition Table
# --------------------------------------------------

partprobe ${TEST_DISK}

sleep 2

# --------------------------------------------------
# Verify Partition Layout
# --------------------------------------------------

lsblk ${TEST_DISK}

fdisk -l ${TEST_DISK}

# --------------------------------------------------
# Create XFS Filesystem
# --------------------------------------------------

mkfs.xfs ${TEST_DISK}1 -f

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to create XFS filesystem" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: XFS filesystem created successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Create Mount Point
# --------------------------------------------------

mkdir -p ${MOUNT_POINT}

# --------------------------------------------------
# Mount Filesystem
# --------------------------------------------------

mount ${TEST_DISK}1 ${MOUNT_POINT}

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to mount filesystem" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Filesystem mounted successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Configure Persistent Mount
# --------------------------------------------------

UUID=$(blkid -s UUID -o value ${TEST_DISK}1)

echo "UUID=${UUID} ${MOUNT_POINT} xfs defaults 0 0" \
>> /etc/fstab

echo "$(date) INFO: Persistent mount configured in /etc/fstab" \
>> ${LOG_FILE}

# --------------------------------------------------
# Validate Mounted Filesystem
# --------------------------------------------------

df -h | grep ${MOUNT_POINT}

mount | grep ${MOUNT_POINT}

# --------------------------------------------------
# Create Test Data
# --------------------------------------------------

mkdir -p ${MOUNT_POINT}/lab-data

touch ${MOUNT_POINT}/lab-data/test-file-{1..5}.txt

echo "Enterprise Linux Filesystem Validation" \
> ${MOUNT_POINT}/lab-data/validation.txt

# --------------------------------------------------
# Verify Test Files
# --------------------------------------------------

ls -lh ${MOUNT_POINT}/lab-data

cat ${MOUNT_POINT}/lab-data/validation.txt

# --------------------------------------------------
# Validate fstab Configuration
# --------------------------------------------------

mount -a

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Invalid /etc/fstab configuration" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: /etc/fstab validation completed successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Final Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " Test Filesystem Setup Completed"
echo "--------------------------------------"

echo "Disk Device  : ${TEST_DISK}"
echo "Mount Point  : ${MOUNT_POINT}"
echo "Filesystem   : XFS"
echo "Log File     : ${LOG_FILE}"

echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
