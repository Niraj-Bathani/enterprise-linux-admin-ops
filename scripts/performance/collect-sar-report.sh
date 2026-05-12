#!/bin/bash

# --------------------------------------------------
# Enterprise Linux SAR Performance Collection Script
# RHEL 9.6 Monitoring Workflow
# --------------------------------------------------

DATE=$(date +%F-%H-%M)

REPORT_DIR="/var/log/performance"
REPORT_FILE="sar-report-${DATE}.log"

LOG_FILE="/var/log/sar-collection.log"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

mkdir -p ${REPORT_DIR}

if ! command -v sar &> /dev/null; then
    echo "$(date) ERROR: sysstat package not installed" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Collect CPU Statistics
# --------------------------------------------------

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo " CPU UTILIZATION REPORT" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

sar -u 1 5 >> ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# Collect Memory Statistics
# --------------------------------------------------

echo "" >> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo " MEMORY UTILIZATION REPORT" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

sar -r 1 5 >> ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# Collect Disk I/O Statistics
# --------------------------------------------------

echo "" >> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo " DISK I/O REPORT" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

sar -d 1 5 >> ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# Collect Network Statistics
# --------------------------------------------------

echo "" >> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo " NETWORK UTILIZATION REPORT" \
>> ${REPORT_DIR}/${REPORT_FILE}

echo "======================================" \
>> ${REPORT_DIR}/${REPORT_FILE}

sar -n DEV 1 5 >> ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# Validate Report Generation
# --------------------------------------------------

if [ ! -f "${REPORT_DIR}/${REPORT_FILE}" ]; then
    echo "$(date) ERROR: SAR report generation failed" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Log Successful Completion
# --------------------------------------------------

echo "$(date) INFO: SAR performance report created: ${REPORT_FILE}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Summary
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise SAR Report Generated"
echo "--------------------------------------"
echo "Report File : ${REPORT_DIR}/${REPORT_FILE}"
echo "Log File    : ${LOG_FILE}"
echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
