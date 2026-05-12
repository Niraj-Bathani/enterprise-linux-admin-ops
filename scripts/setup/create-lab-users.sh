#!/bin/bash

# --------------------------------------------------
# Enterprise Linux Lab User Creation Script
# RHEL 9.6 Lab Environment Setup
# --------------------------------------------------

LOG_FILE="/var/log/create-lab-users.log"

DEFAULT_PASSWORD="LabPassword123"

LAB_USERS=(
    analyst01
    developer01
    operator01
    support01
)

# --------------------------------------------------
# Initial Validation
# --------------------------------------------------

echo "--------------------------------------"
echo " Enterprise Lab User Setup"
echo "--------------------------------------"

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: Script must be run as root"
    exit 1
fi

# --------------------------------------------------
# Create User Accounts
# --------------------------------------------------

for USERNAME in "${LAB_USERS[@]}"
do

    id ${USERNAME} &> /dev/null

    if [ $? -eq 0 ]; then

        echo "$(date) WARNING: User already exists: ${USERNAME}" \
        >> ${LOG_FILE}

        continue
    fi

    useradd -m -s /bin/bash ${USERNAME}

    if [ $? -ne 0 ]; then
        echo "$(date) ERROR: Failed to create user: ${USERNAME}" \
        >> ${LOG_FILE}
        continue
    fi

    echo "${USERNAME}:${DEFAULT_PASSWORD}" | chpasswd

    passwd -e ${USERNAME}

    mkdir -p /home/${USERNAME}/lab-data

    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/lab-data

    chmod 700 /home/${USERNAME}/lab-data

    echo "$(date) INFO: User created successfully: ${USERNAME}" \
    >> ${LOG_FILE}

done

# --------------------------------------------------
# Configure Shared Lab Group
# --------------------------------------------------

groupadd labadmins 2>/dev/null

for USERNAME in "${LAB_USERS[@]}"
do
    usermod -aG labadmins ${USERNAME}
done

echo "$(date) INFO: Users added to labadmins group" \
>> ${LOG_FILE}

# --------------------------------------------------
# Verify User Accounts
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " USER ACCOUNT VALIDATION"
echo "--------------------------------------"

for USERNAME in "${LAB_USERS[@]}"
do
    id ${USERNAME}
done

# --------------------------------------------------
# Verify Home Directories
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " HOME DIRECTORY VALIDATION"
echo "--------------------------------------"

ls -ld /home/analyst01
ls -ld /home/developer01
ls -ld /home/operator01
ls -ld /home/support01

# --------------------------------------------------
# Verify Group Membership
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " GROUP MEMBERSHIP VALIDATION"
echo "--------------------------------------"

getent group labadmins

# --------------------------------------------------
# Display Final Summary
# --------------------------------------------------

echo ""
echo "--------------------------------------"
echo " Lab User Setup Completed"
echo "--------------------------------------"

echo "Created Users:"
for USERNAME in "${LAB_USERS[@]}"
do
    echo " - ${USERNAME}"
done

echo ""
echo "Default Password : ${DEFAULT_PASSWORD}"
echo "Log File         : ${LOG_FILE}"

echo "--------------------------------------"

# --------------------------------------------------
# Exit
# --------------------------------------------------

exit 0
