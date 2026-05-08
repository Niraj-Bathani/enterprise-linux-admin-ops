
# VSFTPD Chroot User Configuration

## Objective

Configure and validate chroot-restricted FTP users in a RHEL 9.6 enterprise Linux environment using VSFTPD to improve file transfer security and isolate user access.

---

# Why It Matters

Chroot restrictions are commonly used in enterprise Linux environments to:

- isolate FTP users
- restrict filesystem access
- improve operational security
- prevent unauthorized directory traversal
- protect system files
- support secure file transfer workflows

Restricting FTP users to their home directories reduces exposure to unauthorized access.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| FTP Service | `vsftpd` |
| Configuration File | `/etc/vsftpd/vsftpd.conf` |
| FTP User | `ftpuser` |
| Home Directory | `/home/ftpuser` |

---

# Create FTP User

## Create Local FTP Account

```bash
sudo useradd -m ftpuser
```

## Set User Password

```bash
sudo passwd ftpuser
```

## Verify User Information

```bash
id ftpuser
```

---

# Configure Chroot Restriction

## Edit VSFTPD Configuration

```bash
sudo vi /etc/vsftpd/vsftpd.conf
```

## Add Chroot Settings

```ini
chroot_local_user=YES

allow_writeable_chroot=YES
```

---

# Configure FTP User Directory

## Verify Home Directory

```bash
ls -ld /home/ftpuser
```

## Create Upload Directory

```bash
mkdir /home/ftpuser/uploads
```

## Configure Ownership

```bash
sudo chown ftpuser:ftpuser /home/ftpuser/uploads
```

---

# Restart FTP Service

## Restart VSFTPD

```bash
sudo systemctl restart vsftpd
```

## Verify Service Status

```bash
systemctl status vsftpd
```

---

# Administrative Validation

## Test FTP Login

```bash
ftp localhost
```

## Verify Current Directory

```bash
pwd
```

## Attempt Restricted Navigation

```bash
cd ..
```

## Expected Result

```text
550 Failed to change directory.
```

---

# Firewall Validation

## Verify FTP Service Access

```bash
sudo firewall-cmd --list-all
```

## Verify Passive Ports

```bash
sudo firewall-cmd --list-ports
```

---

# SELinux Validation

## Verify SELinux Mode

```bash
getenforce
```

## Verify FTP SELinux Boolean

```bash
getsebool ftp_home_dir
```

## Verify User Directory Context

```bash
ls -Zd /home/ftpuser
```

---

# Logging Validation

## Review VSFTPD Logs

```bash
sudo journalctl -u vsftpd
```

## Review Authentication Logs

```bash
sudo grep vsftpd /var/log/secure
```

## Review Transfer Logs

```bash
sudo tail -f /var/log/xferlog
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| FTP login denied | Incorrect credentials | Verify local user password |
| Chroot not enforced | Missing chroot setting | Enable `chroot_local_user=YES` |
| FTP blocked | Firewall restriction | Allow FTP service |
| SELinux denial | Incorrect SELinux policy | Enable FTP SELinux boolean |

---

# Operational Quality Notes

This VSFTPD chroot deployment reflects enterprise Linux file transfer security practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- user directory isolation
- FTP authentication controls
- firewall accessibility
- SELinux policy state
- transfer logging visibility
- restricted filesystem navigation

FTP user access should be reviewed regularly to ensure proper isolation and prevent unauthorized filesystem exposure.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| VSFTPD chroot validation | `vsftpd-chroot-validation.png` |

---

# Screenshot Reference


![VSFTPD Chroot Validation](../screenshots/vsftpd-chroot-validation.png)
