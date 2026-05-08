#!/bin/bash
# Verify a new RHEL-compatible installation after first boot.
set -euo pipefail
log() { printf '[INFO] %s\n' "$*"; }
warn() { printf '[WARN] %s\n' "$*" >&2; }
log "OS release"; cat /etc/os-release
log "Kernel and uptime"; uname -r; uptime
log "Systemd health"; systemctl is-system-running || warn "System is not fully running; inspect failed units."
systemctl --failed --no-pager || true
log "Network state"; ip addr show; ip route show
log "Repository state"; command -v dnf >/dev/null 2>&1 && dnf repolist || warn "DNF unavailable or repository check failed."
log "Security state"; getenforce 2>/dev/null || warn "SELinux tools not installed."
systemctl is-active firewalld >/dev/null 2>&1 && firewall-cmd --list-all || warn "firewalld inactive or unavailable."
log "Storage"; lsblk -f; df -hT
log "Verification complete. Review warnings before continuing labs."
