#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Disk Usage Reporting Script
# RHEL 9.6 Storage Monitoring Utility
# --------------------------------------------------

LOG_FILE="/var/log/disk-usage-report.log"

REPORT_DIR="/var/log/storage-reports"
REPORT_FILE="disk-usage-report-$(date +%F-%H-%M).log"

DISK_THRESHOLD=80

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Disk Usage Report"
echo "--------------------------------------"

mkdir -p ${REPORT_DIR}

# --------------------------------------------------
# Collect Filesystem Usage
# --------------------------------------------------

FILESYSTEM_REPORT=$(df -h)

# --------------------------------------------------
# Generate Storage Report
# --------------------------------------------------

{
echo "======================================"
echo " Enterprise Disk Usage Report"
echo "======================================"
echo "Timestamp : $(date)"
echo "Hostname  : $(hostname)"
echo ""

echo "--------------------------------------"
echo " FILESYSTEM UTILIZATION"
echo "--------------------------------------"

df -h

echo ""
echo "--------------------------------------"
echo " TOP DIRECTORY USAGE"
echo "--------------------------------------"

du -xh /var --max-depth=1 2>/dev/null | sort -hr | head -10

echo ""
echo "--------------------------------------"
echo " BLOCK DEVICE LAYOUT"
echo "--------------------------------------"

lsblk

echo ""
echo "--------------------------------------"
echo " MOUNTED FILESYSTEMS"
echo "--------------------------------------"

mount

echo ""
echo "--------------------------------------"
echo " INODE UTILIZATION"
echo "--------------------------------------"

df -ih

echo ""
echo "--------------------------------------"
echo " LARGEST FILES"
echo "--------------------------------------"

find /var -type f -exec du -h {} + 2>/dev/null | \
sort -hr | head -10

echo ""
echo "--------------------------------------"
echo " ACTIVE STORAGE DEVICES"
echo "--------------------------------------"

fdisk -l 2>/dev/null | grep "^Disk /dev"

} > ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# Validate Disk Usage Threshold
# --------------------------------------------------

df -hP | awk 'NR>1 {print $5 " " $6}' | while read output;
do

    USAGE=$(echo $output | awk '{print $1}' | cut -d'%' -f1)

    PARTITION=$(echo $output | awk '{print $2}')

    if [ ${USAGE} -ge ${DISK_THRESHOLD} ]; then

        echo "$(date) WARNING: High disk usage detected on ${PARTITION}: ${USAGE}%" \
        >> ${LOG_FILE}

    fi

done

# --------------------------------------------------
# Validate Report Generation
# --------------------------------------------------

if [ ! -f "${REPORT_DIR}/${REPORT_FILE}" ]; then

    echo "$(date) ERROR: Failed to generate disk usage report" \
    >> ${LOG_FILE}

    exit 1
fi

# --------------------------------------------------
# Log Successful Completion
# --------------------------------------------------

echo "$(date) INFO: Disk usage report generated successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Filesystem Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " FILESYSTEM SUMMARY"
echo "--------------------------------------"

df -h

# --------------------------------------------------
# Display Final Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " Disk Usage Reporting Completed"
echo "--------------------------------------"

echo "Report File : ${REPORT_DIR}/${REPORT_FILE}"
echo "Log File    : ${LOG_FILE}"

echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
