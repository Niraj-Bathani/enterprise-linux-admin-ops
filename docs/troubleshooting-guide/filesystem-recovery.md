# Filesystem Recovery

## Purpose

Filesystem Recovery is a quick-reference guide for incident response on Linux systems. Troubleshooting is a disciplined loop: define the symptom, collect evidence, form a hypothesis, test one variable, and document the result. Skipping steps feels faster but often extends outages.

## Data To Collect

| Command | Typical use |
|---|---|
| `lsblk -f` | Inspect, configure, or validate the storage area in a repeatable way. |
| `blkid` | Inspect, configure, or validate the storage area in a repeatable way. |
| `parted /dev/sdb print` | Inspect, configure, or validate the storage area in a repeatable way. |
| `mkfs.xfs /dev/sdb1` | Inspect, configure, or validate the storage area in a repeatable way. |
| `mount /dev/sdb1 /mnt/data` | Inspect, configure, or validate the storage area in a repeatable way. |

## Example Collection

```bash
lsblk -f
blkid
parted /dev/sdb print
mkfs.xfs /dev/sdb1
mount /dev/sdb1 /mnt/data
```

## How To Think About Results

Look for the first failing layer. In a network case, name resolution may fail before routing is relevant. In a filesystem case, an application error may be caused by permissions, SELinux labels, quota, or a read-only remount. In a performance case, check whether the issue is saturation, latency, errors, or external dependency failure.

## Escalation Notes

Escalate with evidence instead of conclusions. Include timestamps, hostname, service name, recent changes, commands run, important logs, and impact. If you changed anything, include the exact command and whether it helped. Clear notes reduce repeated work and make root cause analysis possible after service is restored.

## Operator Notes

Treat Filesystem Recovery as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
