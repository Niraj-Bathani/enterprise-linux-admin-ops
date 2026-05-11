# Example enterprise vsftpd configuration for RHEL 9

anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022

dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES

xferlog_std_format=YES
listen=NO
listen_ipv6=YES

pam_service_name=vsftpd
userlist_enable=YES

tcp_wrappers=YES

# Local user restrictions
chroot_local_user=YES
allow_writeable_chroot=YES

# Passive mode configuration
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=31000

# SSL/TLS configuration
ssl_enable=YES
rsa_cert_file=/etc/pki/tls/certs/vsftpd.pem
rsa_private_key_file=/etc/pki/tls/private/vsftpd.key

# Logging
dual_log_enable=YES
vsftpd_log_file=/var/log/vsftpd.log

# Anonymous upload settings
anon_upload_enable=NO
anon_mkdir_write_enable=NO

# Local user upload permissions
local_root=/home/$USER/ftp

# Banner message
ftpd_banner=Enterprise FTP Service - Authorized Access Only

# Idle timeout
idle_session_timeout=600
data_connection_timeout=120

# SELinux compatibility
seccomp_sandbox=NO
