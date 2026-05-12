#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Automated Backup Script
# RHEL 9.6 Backup Workflow
# --------------------------------------------------

DATE=$(date +%F-%H-%M)

BACKUP_DIR="/backup"
SOURCE_DIR="/srv/application-data"

ARCHIVE_NAME="app-backup-${DATE}.tar.gz"
CHECKSUM_FILE="${ARCHIVE_NAME}.sha256"

LOG_FILE="/var/log/backup-script.log"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

mkdir -p ${BACKUP_DIR}

if [ ! -d "${SOURCE_DIR}" ]; then
    echo "$(date) ERROR: Source directory does not exist: ${SOURCE_DIR}" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Create Backup Archive
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
> ${BACKUP_DIR}/${CHECKSUM_FILE}

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
    echo "$(date) ERROR: Backup archive integrity validation failed" \
    >> ${LOG_FILE}
    exit 1
fi

# --------------------------------------------------
# Cleanup Old Backups
# Retain Last 7 Days
# --------------------------------------------------

find ${BACKUP_DIR} -name "*.tar.gz" -mtime +7 -delete

find ${BACKUP_DIR} -name "*.sha256" -mtime +7 -delete

# --------------------------------------------------
# Logging
# --------------------------------------------------

echo "$(date) INFO: Backup completed successfully: ${ARCHIVE_NAME}" \
>> ${LOG_FILE}

echo "$(date) INFO: SHA256 checksum generated: ${CHECKSUM_FILE}" \
>> ${LOG_FILE}

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
