#!/bin/bash

# --------------------------------------------------
# Enterprise Linux CPU & Memory Monitoring Script
# RHEL 9.6 Operational Monitoring Workflow
# --------------------------------------------------

DATE=$(date +%F-%H-%M)

REPORT_DIR="/var/log/performance"
REPORT_FILE="cpu-memory-monitor-${DATE}.log"

LOG_FILE="/var/log/cpu-memory-monitor.log"

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

mkdir -p ${REPORT_DIR}

# --------------------------------------------------
# Collect CPU Utilization
# --------------------------------------------------

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

# --------------------------------------------------
# Collect Memory Utilization
# --------------------------------------------------

MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100.0}')

# --------------------------------------------------
# Generate Monitoring Report
# --------------------------------------------------

{
echo "======================================"
echo " Enterprise CPU & Memory Report"
echo "======================================"
echo "Timestamp        : $(date)"
echo "Hostname         : $(hostname)"
echo ""
echo "CPU Usage (%)    : ${CPU_USAGE}"
echo "Memory Usage (%) : ${MEMORY_USAGE}"
echo ""
echo "--------------------------------------"
echo " TOP PROCESSES"
echo "--------------------------------------"

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -10

echo ""
echo "--------------------------------------"
echo " MEMORY STATISTICS"
echo "--------------------------------------"

free -h

echo ""
echo "--------------------------------------"
echo " CPU LOAD"
echo "--------------------------------------"

uptime

echo ""
echo "--------------------------------------"
echo " ACTIVE SERVICES"
echo "--------------------------------------"

systemctl --type=service --state=running | head -15

} >> ${REPORT_DIR}/${REPORT_FILE}

# --------------------------------------------------
# CPU Threshold Validation
# --------------------------------------------------

CPU_INT=$(printf "%.0f" ${CPU_USAGE})

if [ ${CPU_INT} -ge ${CPU_THRESHOLD} ]; then
    echo "$(date) WARNING: High CPU usage detected: ${CPU_USAGE}%" \
    >> ${LOG_FILE}
fi

# --------------------------------------------------
# Memory Threshold Validation
# --------------------------------------------------

if [ ${MEMORY_USAGE} -ge ${MEMORY_THRESHOLD} ]; then
    echo "$(date) WARNING: High memory usage detected: ${MEMORY_USAGE}%" \
    >> ${LOG_FILE}
fi

# --------------------------------------------------
# Log Successful Execution
# --------------------------------------------------

echo "$(date) INFO: CPU and memory monitoring completed" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Monitoring Summary
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Monitoring Completed"
echo "--------------------------------------"
echo "CPU Usage (%)    : ${CPU_USAGE}"
echo "Memory Usage (%) : ${MEMORY_USAGE}"
echo "Report File      : ${REPORT_DIR}/${REPORT_FILE}"
echo "Log File         : ${LOG_FILE}"
echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
