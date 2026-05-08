# NFS Shared Storage Architecture

Import the following Mermaid diagram into draw.io.

```mermaid
graph TD

    subgraph CLIENT_LAYER[Linux Client Systems]
        CLIENT01[CLIENT01\n192.168.100.50]
        WEB01[WEB01\n192.168.100.20]
        WEB02[WEB02\n192.168.100.21]
    end

    subgraph STORAGE_LAYER[NFS Storage Infrastructure]
        NFS01[NFS01\nNFS Storage Server\n192.168.100.40]
    end

    CLIENT01 -->|NFS Mount| NFS01
    WEB01 -->|Shared Storage| NFS01
    WEB02 -->|Shared Storage| NFS01
```

Recommended draw.io styling:

- Use dark enterprise theme
- Use green for storage server
- Use blue for client systems
- Use arrows showing NFS traffic flow
- Add title:
  Enterprise NFS Shared Storage Architecture

Operational Notes:

- Shared directory:
  /srv/nfs/shared

- NFS export file:
  /etc/exports

- NFS service:
  nfs-server

- Persistent mounts configured using:
  /etc/fstab

Validation Commands:

```bash
showmount -e 192.168.100.40
mount | grep nfs
systemctl status nfs-server
df -h
```

Screenshot Reference:

![NFS Shared Storage Validation](../screenshots/nfs-shared-storage-validation.png)

