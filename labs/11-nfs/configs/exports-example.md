# /etc/exports example configuration
# Enterprise NFS export policies for RHEL 9

# Shared application data
/data/apps 192.168.1.0/24(rw,sync,no_root_squash)

# Read-only software repository
/repo 192.168.1.0/24(ro,sync)

# Backup storage export
/backup 192.168.1.50(rw,sync,no_subtree_check)

# Development shared directory
/devshare 192.168.1.100(rw,sync)

# Secure finance share
/finance 192.168.1.200(rw,sync,root_squash)

# Home directory export
/home 192.168.1.0/24(rw,sync,no_subtree_check)

# Media archive export
/archive 192.168.1.150(ro,sync)

# QA environment export
/qa-share 192.168.1.0/24(rw,sync)

# Engineering shared storage
/engineering 192.168.1.75(rw,sync,no_root_squash)

# Restricted admin share
/admin-tools 192.168.1.10(rw,sync,root_squash)
