#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Live Backup Script
# RHEL 9.6 Operational Backup Workflow
# --------------------------------------------------

DATE=$(date +%F-%H-%M)

SOURCE_DIR="/srv/live-data"
BACKUP_DIR="/backup/live"
LOG_FILE="/var/log/live-backup.log"

ARCHIVE_NAME="live-backup-${DATE}.tar.gz"
CHECKSUM_NAME="${ARCHIVE_NAME}.sha256"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

mkdir -p ${BACKUP_DIR}

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "$(date) ERROR: Source directory missing: ${SOURCE_DIR}" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Verify Available Storage
# --------------------------------------------------

AVAILABLE_SPACE=$(df -h /backup | awk 'NR==2 {print $4}')

echo "$(date) INFO: Available backup storage: ${AVAILABLE_SPACE}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Create Compressed Backup Archive
# --------------------------------------------------

tar -czf ${BACKUP_DIR}/${ARCHIVE_NAME} ${SOURCE_DIR}

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Backup archive creation failed" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Generate SHA256 Checksum
# --------------------------------------------------

sha256sum ${BACKUP_DIR}/${ARCHIVE_NAME} \
> ${BACKUP_DIR}/${CHECKSUM_NAME}

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Checksum generation failed" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Validate Archive Integrity
# --------------------------------------------------

gzip -t ${BACKUP_DIR}/${ARCHIVE_NAME}

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Backup integrity validation failed" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Remove Old Backups
# Retain Last 7 Days
# --------------------------------------------------

find ${BACKUP_DIR} -name "*.tar.gz" -mtime +7 -delete

find ${BACKUP_DIR} -name "*.sha256" -mtime +7 -delete

# --------------------------------------------------
# Log Successful Completion
# --------------------------------------------------

echo "$(date) INFO: Backup completed successfully: ${ARCHIVE_NAME}" \
>> ${LOG_FILE}

echo "$(date) INFO: SHA256 checksum created: ${CHECKSUM_NAME}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Display Backup Summary
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Live Backup Completed"
echo "--------------------------------------"
echo "Source Directory : ${SOURCE_DIR}"
echo "Backup Directory : ${BACKUP_DIR}"
echo "Archive Name     : ${ARCHIVE_NAME}"
echo "Checksum File    : ${CHECKSUM_NAME}"
echo "Log File         : ${LOG_FILE}"
echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
