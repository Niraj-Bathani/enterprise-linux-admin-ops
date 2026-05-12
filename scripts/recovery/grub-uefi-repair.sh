#!/bin/bash

# --------------------------------------------------
# Enterprise Linux UEFI GRUB Repair Script
# RHEL 9.6 Recovery Workflow
# --------------------------------------------------

LOG_FILE="/var/log/grub-uefi-repair.log"

EFI_MOUNT="/boot/efi"
EFI_PARTITION="/dev/sda1"

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise UEFI GRUB Recovery"
echo "--------------------------------------"

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Script must be run as root"
    exit 1
fi

# --------------------------------------------------
# Verify UEFI Environment
# --------------------------------------------------

if [ ! -d "/sys/firmware/efi" ]; then
    echo "$(date) ERROR: System is not booted in UEFI mode" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: UEFI environment detected" \
>> ${LOG_FILE}

# --------------------------------------------------
# Mount EFI Partition
# --------------------------------------------------

mkdir -p ${EFI_MOUNT}

mount ${EFI_PARTITION} ${EFI_MOUNT}

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: Failed to mount EFI partition" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: EFI partition mounted successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Reinstall GRUB Bootloader
# --------------------------------------------------

grub2-install \
--target=x86_64-efi \
--efi-directory=${EFI_MOUNT} \
--bootloader-id=RHEL

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: GRUB installation failed" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: GRUB bootloader installed successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Regenerate GRUB Configuration
# --------------------------------------------------

grub2-mkconfig -o /boot/grub2/grub.cfg

if [ $? -ne 0 ]; then
    echo "$(date) ERROR: GRUB configuration generation failed" \
    >> ${LOG_FILE}
    exit 1
fi

echo "$(date) INFO: GRUB configuration regenerated successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Verify EFI Boot Entries
# --------------------------------------------------

efibootmgr

if [ $? -ne 0 ]; then
    echo "$(date) WARNING: Unable to verify EFI boot entries" \
    >> ${LOG_FILE}
fi

# --------------------------------------------------
# Verify Mounted EFI Filesystem
# --------------------------------------------------

ls -lh ${EFI_MOUNT}/EFI

# --------------------------------------------------
# Final Validation
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " GRUB UEFI Recovery Completed"
echo "--------------------------------------"

echo "EFI Partition : ${EFI_PARTITION}"
echo "EFI Mount     : ${EFI_MOUNT}"
echo "Log File      : ${LOG_FILE}"

echo "--------------------------------------"

echo "$(date) INFO: UEFI recovery workflow completed successfully" \
>> ${LOG_FILE}

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
