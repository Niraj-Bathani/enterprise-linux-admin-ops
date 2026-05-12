#!/bin/bash

# --------------------------------------------------
# Enterprise Linux LVM Recovery Helper Script
# RHEL 9.6 Recovery Workflow
# --------------------------------------------------

LOG_FILE="/var/log/lvm-recovery-helper.log"

RECOVERY_REPORT="/var/log/lvm-recovery-report.txt"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise LVM Recovery Helper"
echo "--------------------------------------"

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Script must be run as root"
    exit 1
fi

# --------------------------------------------------
# Validate LVM Utilities
# --------------------------------------------------

if ! command -v lvs &> /dev/null; then
    echo "$(date) ERROR: LVM utilities not installed" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: LVM utilities detected" \
>> ${LOG_FILE}

# --------------------------------------------------
# Generate Recovery Report
# --------------------------------------------------

{
echo "======================================"
echo " Enterprise Linux LVM Recovery Report"
echo "======================================"
echo "Timestamp : $(date)"
echo "Hostname  : $(hostname)"
echo ""

echo "--------------------------------------"
echo " PHYSICAL VOLUMES"
echo "--------------------------------------"

pvs

echo ""
echo "--------------------------------------"
echo " VOLUME GROUPS"
echo "--------------------------------------"

vgs

echo ""
echo "--------------------------------------"
echo " LOGICAL VOLUMES"
echo "--------------------------------------"

lvs

echo ""
echo "--------------------------------------"
echo " BLOCK DEVICES"
echo "--------------------------------------"

lsblk

echo ""
echo "--------------------------------------"
echo " FILESYSTEM USAGE"
echo "--------------------------------------"

df -h

echo ""
echo "--------------------------------------"
echo " MOUNTED FILESYSTEMS"
echo "--------------------------------------"

mount | grep mapper

echo ""
echo "--------------------------------------"
echo " LVM DEVICE DETAILS"
echo "--------------------------------------"

lvdisplay

echo ""
echo "--------------------------------------"
echo " VOLUME GROUP DETAILS"
echo "--------------------------------------"

vgdisplay

echo ""
echo "--------------------------------------"
echo " PHYSICAL VOLUME DETAILS"
echo "--------------------------------------"

pvdisplay

} > ${RECOVERY_REPORT}

# --------------------------------------------------
# Validate LVM Metadata Backup
# --------------------------------------------------

vgcfgbackup

if [ $? -ne 0 ]; then
    echo "$(date) WARNING: Failed to create LVM metadata backup" \
    >> ${LOG_FILE}
else
    echo "$(date) INFO: LVM metadata backup completed" \
    >> ${LOG_FILE}
fi

# --------------------------------------------------
# Scan and Activate Volume Groups
# --------------------------------------------------

vgscan

vgchange -ay

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to activate volume groups" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: Volume groups activated successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Verify Active Logical Volumes
# --------------------------------------------------

lvs

# --------------------------------------------------
# Validate Mounted Filesystems
# --------------------------------------------------

mount | grep mapper

# --------------------------------------------------
# Log Successful Completion
# --------------------------------------------------

echo "$(date) INFO: LVM recovery validation completed successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Recovery Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " LVM Recovery Validation Completed"
echo "--------------------------------------"

echo "Recovery Report : ${RECOVERY_REPORT}"
echo "Log File        : ${LOG_FILE}"

echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
