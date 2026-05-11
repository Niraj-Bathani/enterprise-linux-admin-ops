#!/bin/bash

# ==========================================================
# Enterprise Linux Users, Permissions, and Sudo Lab Tasks
# Platform : RHEL 9
# Purpose  : User administration and permission validation
# ==========================================================

echo "=================================================="
echo " Enterprise Linux Access Control Lab"
echo "=================================================="
echo

# ----------------------------------------------------------
# User and Group Creation
# ----------------------------------------------------------

echo "[+] Creating Users and Groups"

groupadd project-team
groupadd sysadmins

useradd devuser01
useradd qauser01
useradd opsuser01

echo

# ----------------------------------------------------------
# Verify Users and Groups
# ----------------------------------------------------------

echo "[+] Verifying User Accounts"

id devuser01
id qauser01
id opsuser01

echo

echo "[+] Verifying Groups"

getent group project-team
getent group sysadmins

echo

# ----------------------------------------------------------
# Group Membership Management
# ----------------------------------------------------------

echo "[+] Adding Users to Groups"

usermod -aG project-team devuser01
usermod -aG project-team qauser01
usermod -aG sysadmins opsuser01

echo

echo "[+] Validating Group Membership"

groups devuser01
groups qauser01
groups opsuser01

echo

# ----------------------------------------------------------
# Secure Directory Creation
# ----------------------------------------------------------

echo "[+] Creating Secure Working Directories"

mkdir -p /shared-projects
mkdir -p /secure-admin

echo

# ----------------------------------------------------------
# Ownership Configuration
# ----------------------------------------------------------

echo "[+] Configuring Ownership"

chown root:project-team /shared-projects
chown root:sysadmins /secure-admin

echo

# ----------------------------------------------------------
# Standard Permission Configuration
# ----------------------------------------------------------

echo "[+] Applying Directory Permissions"

chmod 770 /shared-projects
chmod 750 /secure-admin

echo

echo "[+] Verifying Permissions"

ls -ld /shared-projects
ls -ld /secure-admin

echo

# ----------------------------------------------------------
# ACL Configuration
# ----------------------------------------------------------

echo "[+] Configuring ACL Permissions"

setfacl -m u:devuser01:rwx /shared-projects
setfacl -m u:qauser01:rwx /shared-projects

echo

echo "[+] Validating ACLs"

getfacl /shared-projects

echo

# ----------------------------------------------------------
# Default ACL Configuration
# ----------------------------------------------------------

echo "[+] Configuring Default ACLs"

setfacl -d -m g:project-team:rwx /shared-projects

echo

echo "[+] Validating Default ACLs"

getfacl /shared-projects

echo

# ----------------------------------------------------------
# File Creation Validation
# ----------------------------------------------------------

echo "[+] Creating Test Files"

sudo -u devuser01 touch /shared-projects/dev-file.txt
sudo -u qauser01 touch /shared-projects/qa-file.txt

echo

echo "[+] Validating File Ownership"

ls -l /shared-projects

echo

# ----------------------------------------------------------
# Sudo Access Configuration
# ----------------------------------------------------------

echo "[+] Configuring Sudo Access"

echo "%sysadmins ALL=(ALL) NOPASSWD: ALL" \
> /etc/sudoers.d/sysadmins

chmod 440 /etc/sudoers.d/sysadmins

echo

# ----------------------------------------------------------
# Validate sudoers Configuration
# ----------------------------------------------------------

echo "[+] Validating sudo Configuration"

visudo -c

echo

# ----------------------------------------------------------
# Sudo Access Testing
# ----------------------------------------------------------

echo "[+] Testing Sudo Access"

sudo -u opsuser01 sudo hostname

echo

# ----------------------------------------------------------
# Permission Restriction Validation
# ----------------------------------------------------------

echo "[+] Validating Restricted Access"

sudo -u qauser01 ls /secure-admin

echo

# ----------------------------------------------------------
# umask Validation
# ----------------------------------------------------------

echo "[+] Current umask"

umask

echo

# ----------------------------------------------------------
# Special Permission Validation
# ----------------------------------------------------------

echo "[+] Creating Shared Collaboration Directory"

mkdir -p /team-share

chmod 2770 /team-share

echo

echo "[+] Verifying SGID Permission"

ls -ld /team-share

echo

# ----------------------------------------------------------
# SELinux Validation
# ----------------------------------------------------------

echo "[+] SELinux Status"

getenforce

echo

# ----------------------------------------------------------
# Filesystem Validation
# ----------------------------------------------------------

echo "[+] Filesystem Validation"

df -hT

echo

# ----------------------------------------------------------
# Permission Auditing
# ----------------------------------------------------------

echo "[+] Auditing World Writable Files"

find /shared-projects -perm -002

echo

echo "[+] Auditing SUID Files"

find / -perm -4000 2>/dev/null | head

echo

# ----------------------------------------------------------
# Final Summary
# ----------------------------------------------------------

echo "=================================================="
echo " Access Control Lab Completed"
echo "=================================================="
