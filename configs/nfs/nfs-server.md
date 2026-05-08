# NFS Server Configuration

## Objective

Configure an NFS server in a RHEL 9.6 enterprise Linux environment to provide centralized shared storage access for Linux clients across the internal infrastructure network.

---

# Why It Matters

Network File System (NFS) is commonly used in enterprise Linux environments for:

- centralized shared storage
- application data sharing
- backup repositories
- user home directories
- multi-server content access
- infrastructure administration

Proper NFS configuration improves operational consistency and simplifies shared storage management.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| NFS Server | `NFS01` |
| Service Name | `nfs-server` |
| Shared Network | `192.168.100.0/24` |
| Export Path | `/srv/nfs/shared` |

---

# NFS Server Installation

## Install NFS Utilities

```bash
sudo dnf install nfs-utils -y
```

## Enable NFS Services

```bash
sudo systemctl enable --now nfs-server
sudo systemctl enable --now rpcbind
```

## Verify Service Status

```bash
systemctl status nfs-server
```

---

# Shared Storage Preparation

## Create Shared Directory

```bash
sudo mkdir -p /srv/nfs/shared
```

## Configure Permissions

```bash
sudo chown -R nfsnobody:nfsnobody /srv/nfs/shared
sudo chmod 755 /srv/nfs/shared
```

## Create Test File

```bash
sudo touch /srv/nfs/shared/nfs-validation.txt
```

---

# NFS Export Configuration

## Edit Export Configuration

```bash
sudo vi /etc/exports
```

## Example Export Rule

```bash
/srv/nfs/shared 192.168.100.0/24(rw,sync,no_root_squash)
```

## Apply Export Configuration

```bash
sudo exportfs -rav
```

## Verify Exported Shares

```bash
showmount -e localhost
```

---

# Firewall Validation

## Allow NFS Services

```bash
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --permanent --add-service=mountd
sudo firewall-cmd --permanent --add-service=rpc-bind
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

## Enable NFS Export Access

```bash
sudo setsebool -P nfs_export_all_rw on
```

## Verify SELinux Boolean

```bash
getsebool nfs_export_all_rw
```

---

# Verification

## Verify Listening Ports

```bash
ss -tulpn | grep nfs
```

## Verify Exported Shares

```bash
showmount -e localhost
```

## Verify NFS Service Status

```bash
systemctl status nfs-server
```

## Validate Shared File Access

```bash
ls -l /srv/nfs/shared
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| Clients cannot mount share | Firewall restriction | Allow NFS services |
| Permission denied | Incorrect export permissions | Validate `/etc/exports` |
| Export not visible | Export not applied | Run `exportfs -rav` |
| SELinux blocking access | Incorrect SELinux policy | Enable NFS SELinux boolean |

---

# Operational Quality Notes

This NFS deployment reflects enterprise Linux storage administration practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- NFS export visibility
- shared storage permissions
- firewall accessibility
- SELinux policy state
- NFS service availability
- client connectivity

NFS environments should be monitored regularly for:

- unauthorized access
- export misconfiguration
- storage permission changes
- service failures

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| NFS server validation | `nfs-server-validation.png` |

---

# Screenshot Reference

![NFS Server Validation](../screenshots/nfs-server-validation.png)
