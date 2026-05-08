
# VSFTPD Server Configuration

## Objective

Configure and validate a secure VSFTPD server in a RHEL 9.6 enterprise Linux environment to provide controlled FTP-based file transfer services for administrative and operational workflows.

---

# Why It Matters

VSFTPD is commonly used in enterprise Linux environments for:

- internal file transfers
- software repository access
- backup transfers
- controlled user uploads
- operational file exchange
- infrastructure administration

Proper FTP server configuration improves operational reliability while reducing exposure to unauthorized access.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| FTP Service | `vsftpd` |
| Configuration File | `/etc/vsftpd/vsftpd.conf` |
| FTP Port | `21/tcp` |
| Passive Port Range | `40000-40100` |

---

# Install VSFTPD

## Install FTP Service

```bash
sudo dnf install vsftpd -y
```

## Verify Package Installation

```bash
rpm -qa | grep vsftpd
```

---

# Configure VSFTPD

## Edit Main Configuration File

```bash
sudo vi /etc/vsftpd/vsftpd.conf
```

## Example Enterprise Configuration

```ini
anonymous_enable=NO

local_enable=YES

write_enable=YES

local_umask=022

dirmessage_enable=YES

xferlog_enable=YES

connect_from_port_20=YES

xferlog_std_format=YES

listen=YES

pam_service_name=vsftpd

userlist_enable=YES

tcp_wrappers=YES

pasv_min_port=40000

pasv_max_port=40100
```

---

# Enable And Start FTP Service

## Enable VSFTPD

```bash
sudo systemctl enable vsftpd
```

## Start FTP Service

```bash
sudo systemctl start vsftpd
```

## Verify Service Status

```bash
systemctl status vsftpd
```

---

# Firewall Validation

## Allow FTP Services

```bash
sudo firewall-cmd --permanent --add-service=ftp
sudo firewall-cmd --permanent --add-port=40000-40100/tcp
sudo firewall-cmd --reload
```

## Verify Firewall Rules

```bash
sudo firewall-cmd --list-all
```

---

# SELinux Validation

## Verify SELinux Mode

```bash
getenforce
```

## Enable FTP Home Directory Access

```bash
sudo setsebool -P ftp_home_dir on
```

## Verify SELinux Boolean

```bash
getsebool ftp_home_dir
```

---

# Administrative Validation

## Verify Listening FTP Port

```bash
ss -tulpn | grep vsftpd
```

## Test Local FTP Connection

```bash
ftp localhost
```

## Verify Running Process

```bash
ps -ef | grep vsftpd
```

---

# Logging Validation

## Review VSFTPD Logs

```bash
sudo journalctl -u vsftpd
```

## Review Transfer Logs

```bash
sudo tail -f /var/log/xferlog
```

## Review Authentication Logs

```bash
sudo grep vsftpd /var/log/secure
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| FTP connection refused | Service not running | Start `vsftpd` |
| Passive mode failure | Firewall restriction | Allow passive ports |
| Authentication failure | Incorrect local account | Verify user credentials |
| SELinux denial | Incorrect SELinux policy | Enable FTP SELinux boolean |

---

# Operational Quality Notes

This VSFTPD deployment reflects enterprise Linux file transfer administration practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- FTP service availability
- passive mode connectivity
- firewall accessibility
- authentication controls
- SELinux policy state
- transfer logging visibility

FTP environments should be monitored regularly for unauthorized uploads, abnormal login attempts, and excessive transfer activity.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| VSFTPD server validation | `vsftpd-server-validation.png` |

---

# Screenshot Reference

![VSFTPD Server Validation](../screenshots/vsftpd-server-validation.png)
