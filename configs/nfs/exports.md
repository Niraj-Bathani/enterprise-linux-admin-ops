# NFS Exports Configuration

## Objective

Configure and manage NFS export rules in a RHEL 9.6 enterprise Linux environment to securely provide shared storage access to authorized client systems.

---

# Why It Matters

The `/etc/exports` file controls how shared directories are exposed to network clients.

Enterprise administrators use NFS exports to:

- restrict client access
- manage read/write permissions
- control root access behavior
- secure shared storage
- standardize storage access policies
- support centralized Linux infrastructure

Improper export configuration can expose sensitive data or disrupt application access.

---

# Environment Information

| Component | Value |
|---|---|
| Operating System | RHEL 9.6 |
| NFS Server | `NFS01` |
| Export File | `/etc/exports` |
| Shared Network | `192.168.100.0/24` |
| Shared Directory | `/srv/nfs/shared` |

---

# NFS Export Configuration

## Edit Export File

```bash
sudo vi /etc/exports
```

## Example Export Rules

```bash
/srv/nfs/shared 192.168.100.0/24(rw,sync,no_root_squash)

/srv/nfs/backups 192.168.100.50(ro,sync)
```

---

# Export Rule Explanation

| Option | Purpose |
|---|---|
| `rw` | Read and write access |
| `ro` | Read-only access |
| `sync` | Write changes immediately |
| `no_root_squash` | Preserve root permissions |
| `root_squash` | Restrict remote root access |

---

# Apply Export Configuration

## Reload Export Rules

```bash
sudo exportfs -rav
```

## Verify Exported Shares

```bash
showmount -e localhost
```

## Verify Active Exports

```bash
exportfs -v
```

---

# Shared Directory Preparation

## Create Shared Directories

```bash
sudo mkdir -p /srv/nfs/shared
sudo mkdir -p /srv/nfs/backups
```

## Configure Permissions

```bash
sudo chmod 755 /srv/nfs/shared
sudo chmod 755 /srv/nfs/backups
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

## Verify Export Visibility

```bash
showmount -e localhost
```

## Verify Export Rules

```bash
exportfs -v
```

## Validate Shared Files

```bash
ls -l /srv/nfs/shared
```

## Verify NFS Services

```bash
systemctl status nfs-server
```

---

# Common Issues And Fixes

| Issue | Cause | Resolution |
|---|---|---|
| Export not visible | Export not applied | Run `exportfs -rav` |
| Permission denied | Incorrect export options | Review `/etc/exports` |
| Client cannot access share | Firewall restrictions | Allow NFS services |
| SELinux blocking exports | Incorrect SELinux policy | Enable NFS SELinux boolean |

---

# Operational Quality Notes

This export configuration reflects enterprise Linux shared storage administration practices commonly used in RHEL 9.6 environments.

Enterprise administrators should validate:

- export visibility
- client access restrictions
- shared storage permissions
- firewall accessibility
- SELinux policy state
- export persistence

Export configurations should be reviewed regularly to ensure only authorized systems retain access.

---

# Screenshot Capture

| Screenshot Requirement | Filename |
|---|---|
| NFS exports validation | `nfs-exports-validation.png` |

---

# Screenshot Reference

![NFS Exports Validation](../screenshots/nfs-exports-validation.png)
