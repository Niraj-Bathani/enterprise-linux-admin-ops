#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Open Files Monitoring Script
# RHEL 9.6 Troubleshooting Utility
# --------------------------------------------------

LOG_FILE="/var/log/check-openfiles.log"

REPORT_DIR="/var/log/openfiles"
REPORT_FILE="openfiles-report-$(date +%F-%H-%M).log"

OPENFILE_THRESHOLD=5000

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Open Files Validation"
echo "--------------------------------------"

mkdir -p ${REPORT_DIR}

# --------------------------------------------------
# Verify lsof Utility
# --------------------------------------------------

if ! command -v lsof &> /dev/null; then
    echo "$(date) ERROR: lsof utility not installed" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: lsof utility detected" \
>> ${LOG_FILE}

# --------------------------------------------------
# Collect Open File Statistics
# --------------------------------------------------

TOTAL_OPEN_FILES=$(lsof | wc -l)

# --------------------------------------------------
# Generate Open Files Report
# --------------------------------------------------

{
echo "======================================"
echo " Enterprise Open Files Report"
echo "======================================"
echo "Timestamp        : $(date)"
echo "Hostname         : $(hostname)"
echo ""
echo "Total Open Files : ${TOTAL_OPEN_FILES}"
echo ""

echo "--------------------------------------"
echo " TOP PROCESSES BY OPEN FILES"
echo "--------------------------------------"

lsof | awk '{print $1}' | sort | uniq -c | sort -nr | head -10

echo ""
echo "--------------------------------------"
echo " ACTIVE NETWORK CONNECTIONS"
echo "--------------------------------------"

ss -antp

echo ""
echo "--------------------------------------"
echo " OPEN FILE LIMITS"
echo "--------------------------------------"

ulimit -n

echo ""
echo "--------------------------------------"
echo " SYSTEM FILE HANDLES"
echo "--------------------------------------"

cat /proc/sys/fs/file-nr

echo ""
echo "--------------------------------------"
echo " TOP OPEN FILE DESCRIPTORS"
echo "--------------------------------------"

lsof | head -25

} > ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# Validate Open File Threshold
# --------------------------------------------------

if [ ${TOTAL_OPEN_FILES} -ge ${OPENFILE_THRESHOLD} ]; then

    echo "$(date) WARNING: High open file count detected: ${TOTAL_OPEN_FILES}" \
    >> ${LOG_FILE}

else

    echo "$(date) INFO: Open file usage within threshold" \
    >> ${LOG_FILE}

fi

# --------------------------------------------------
# Verify Current Limits
# --------------------------------------------------

SOFT_LIMIT=$(ulimit -Sn)
HARD_LIMIT=$(ulimit -Hn)

echo "$(date) INFO: Soft limit=${SOFT_LIMIT}, Hard limit=${HARD_LIMIT}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Active Processes
# --------------------------------------------------

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -15

# --------------------------------------------------
# Validate Report Generation
# --------------------------------------------------

if [ ! -f "${REPORT_DIR}/${REPORT_FILE}" ]; then
    echo "$(date) ERROR: Failed to generate open files report" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Log Successful Completion
# --------------------------------------------------

echo "$(date) INFO: Open files validation completed successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " Open Files Validation Completed"
echo "--------------------------------------"

echo "Total Open Files : ${TOTAL_OPEN_FILES}"
echo "Report File      : ${REPORT_DIR}/${REPORT_FILE}"
echo "Log File         : ${LOG_FILE}"

echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
