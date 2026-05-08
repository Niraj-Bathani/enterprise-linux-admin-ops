# RAID Storage Layout Architecture

Import the following Mermaid diagram into draw.io.

```mermaid
graph TD

    subgraph PHYSICAL_DISKS[Physical Storage Devices]
        SDA[/dev/sda\n50GB]
        SDB[/dev/sdb\n50GB]
        SDC[/dev/sdc\n50GB]
        SDD[/dev/sdd\n50GB]
    end

    subgraph RAID_LAYER[RAID Configuration]
        MD0[md0\nRAID 5 Array]
    end

    subgraph FILESYSTEM_LAYER[Filesystem & Mount]
        XFS[XFS Filesystem]
        MOUNT[/data/storage]
    end

    SDA --> MD0
    SDB --> MD0
    SDC --> MD0
    SDD --> MD0

    MD0 --> XFS
    XFS --> MOUNT
```

Recommended draw.io styling:

- Use dark enterprise theme
- Use gray for physical disks
- Use orange for RAID layer
- Use green for filesystem layer
- Add directional arrows for storage flow
- Add title:
  Enterprise Linux RAID Storage Architecture

Operational Notes:

- RAID type:
  RAID 5

- RAID management utility:
  mdadm

- Filesystem:
  XFS

- Mount point:
  /data/storage

- RAID configuration file:
  /etc/mdadm.conf

Validation Commands:

```bash
cat /proc/mdstat
mdadm --detail /dev/md0
lsblk
df -h
```

Screenshot Reference:

![RAID Array Validation](../screenshots/mdadm-degraded-array.png)


