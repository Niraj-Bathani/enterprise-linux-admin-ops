# ===================================================================
# Apache HTTP Server Security Hardening Configuration
# RHEL 9.6 Enterprise Linux Environment
# ===================================================================
#
# Purpose:
# Enterprise-style Apache hardening configuration used to reduce
# attack surface and improve baseline web server security.
#
# Environment:
# - Red Hat Enterprise Linux 9.6
# - Apache HTTP Server
# - firewalld enabled
# - SELinux enforcing
#
# ===================================================================

# -------------------------------------------------------------------
# Hide Apache version information
# -------------------------------------------------------------------

ServerTokens Prod
ServerSignature Off

# -------------------------------------------------------------------
# Disable HTTP TRACE method
# -------------------------------------------------------------------

TraceEnable Off

# -------------------------------------------------------------------
# Restrict filesystem root access
# -------------------------------------------------------------------

<Directory />
    AllowOverride None
    Require all denied
</Directory>

# -------------------------------------------------------------------
# Secure default web root permissions
# -------------------------------------------------------------------

<Directory "/var/www/html">

    Options -Indexes +FollowSymLinks

    AllowOverride None

    Require all granted

</Directory>

# -------------------------------------------------------------------
# Disable directory listing globally
# -------------------------------------------------------------------

IndexIgnore *

# -------------------------------------------------------------------
# Limit HTTP request body size
# Helps reduce abuse and upload attacks
# -------------------------------------------------------------------

LimitRequestBody 10485760

# -------------------------------------------------------------------
# Security-related HTTP headers
# -------------------------------------------------------------------

Header always append X-Frame-Options SAMEORIGIN
Header set X-XSS-Protection "1; mode=block"
Header set X-Content-Type-Options nosniff

# -------------------------------------------------------------------
# Timeout hardening
# -------------------------------------------------------------------

Timeout 60
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5

# -------------------------------------------------------------------
# Logging configuration
# -------------------------------------------------------------------

ErrorLog logs/hardening-error.log

LogLevel warn

# -------------------------------------------------------------------
# SELinux Operational Notes
# -------------------------------------------------------------------
#
# Validate SELinux contexts:
#
# semanage fcontext -l | grep httpd
# restorecon -Rv /var/www/html
#
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# Firewall Validation
# -------------------------------------------------------------------
#
# firewall-cmd --list-all
# firewall-cmd --add-service=http --permanent
# firewall-cmd --reload
#
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# Apache Validation Commands
# -------------------------------------------------------------------
#
# apachectl configtest
# systemctl restart httpd
# systemctl status httpd
# ss -tulpn | grep httpd
#
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# Screenshot Reference
# -------------------------------------------------------------------
#
# ../screenshots/apache-hardening-validation.png
#
# ===================================================================
