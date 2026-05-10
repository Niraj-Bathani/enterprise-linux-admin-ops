#!/bin/bash

# ==========================================================
# Enterprise Linux Post-Install Verification Script
# Platform : RHEL 8 / RHEL 9
# Purpose  : Validate enterprise baseline configuration
# ==========================================================

echo "=================================================="
echo " Enterprise Linux Post-Install Verification"
echo "=================================================="
echo

# ----------------------------------------------------------
# Operating System Validation
# ----------------------------------------------------------

echo "[+] Operating System Information"
cat /etc/redhat-release
echo

# ----------------------------------------------------------
# Hostname Validation
# ----------------------------------------------------------

echo "[+] Hostname Validation"
hostnamectl --static
echo

# ----------------------------------------------------------
# Network Validation
# ----------------------------------------------------------

echo "[+] Network Interface Validation"
ip -brief address
echo

echo "[+] Default Gateway Validation"
ip route | grep default
echo

echo "[+] DNS Configuration"
cat /etc/resolv.conf
echo

# ----------------------------------------------------------
# Connectivity Validation
# ----------------------------------------------------------

echo "[+] Internet Connectivity Test"
ping -c 2 8.8.8.8 >/dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "PASS : Internet connectivity operational"
else
    echo "FAIL : Internet connectivity unavailable"
fi

echo

# ----------------------------------------------------------
# SELinux Validation
# ----------------------------------------------------------

echo "[+] SELinux Status"
getenforce
echo

# ----------------------------------------------------------
# Firewall Validation
# ----------------------------------------------------------

echo "[+] firewalld Service Validation"
systemctl is-active firewalld
echo

# ----------------------------------------------------------
# SSH Service Validation
# ----------------------------------------------------------

echo "[+] SSH Service Validation"
systemctl is-active sshd
echo

# ----------------------------------------------------------
# Time Synchronization Validation
# ----------------------------------------------------------

echo "[+] Time Synchronization Status"
timedatectl | grep "System clock synchronized"
echo

# ----------------------------------------------------------
# Filesystem Validation
# ----------------------------------------------------------

echo "[+] Filesystem Usage"
df -hT
echo

# ----------------------------------------------------------
# Memory Validation
# ----------------------------------------------------------

echo "[+] Memory Utilization"
free -m
echo

# ----------------------------------------------------------
# CPU Validation
# ----------------------------------------------------------

echo "[+] CPU Information"
lscpu | grep "^CPU(s):"
echo

# ----------------------------------------------------------
# Installed Package Validation
# ----------------------------------------------------------

echo "[+] Required Package Validation"

REQUIRED_PACKAGES=(
    vim
    chrony
    openssh-server
    bash-completion
)

for pkg in "${REQUIRED_PACKAGES[@]}"
do
    rpm -q "$pkg" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "PASS : $pkg installed"
    else
        echo "FAIL : $pkg missing"
    fi
done

echo

# ----------------------------------------------------------
# Service Validation
# ----------------------------------------------------------

echo "[+] Enabled Services"

systemctl is-enabled chronyd
systemctl is-enabled firewalld
systemctl is-enabled sshd

echo

# ----------------------------------------------------------
# UEFI Validation
# ----------------------------------------------------------

echo "[+] UEFI Boot Validation"

if [ -d /sys/firmware/efi ]; then
    echo "PASS : System booted using UEFI"
else
    echo "FAIL : Legacy BIOS mode detected"
fi

echo

# ----------------------------------------------------------
# Final Summary
# ----------------------------------------------------------

echo "=================================================="
echo " Verification Completed"
echo "=================================================="
