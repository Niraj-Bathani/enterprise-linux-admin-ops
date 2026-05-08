# Navigation Filesystem

## When To Use This Sheet

Use this cheat sheet during daily administration and timed lab work. It is intentionally compact, but every command should still be read before it is executed. Replace device names, users, paths, ports, and service names with values from your system. For commands that change state, record the original state first so that rollback is possible.

## Commands

| Command | Typical use |
|---|---|
| `lsblk -f` | Inspect, configure, or validate the storage area in a repeatable way. |
| `blkid` | Inspect, configure, or validate the storage area in a repeatable way. |
| `parted /dev/sdb print` | Inspect, configure, or validate the storage area in a repeatable way. |
| `mkfs.xfs /dev/sdb1` | Inspect, configure, or validate the storage area in a repeatable way. |
| `mount /dev/sdb1 /mnt/data` | Inspect, configure, or validate the storage area in a repeatable way. |

## Patterns

```bash
lsblk -f
blkid
parted /dev/sdb print
mkfs.xfs /dev/sdb1
mount /dev/sdb1 /mnt/data
```

## Reading Output

Focus on names, states, exit codes, and timestamps. For example, a service that is `enabled` is not necessarily `active`; a route in the table does not prove DNS works; and an open port in `ss` may still be blocked by firewalld or SELinux. When the command has a terse output format, repeat it with a verbose flag or query the related journal.

## Safe Practice

Run read-only commands first, then perform one controlled change. After the change, repeat the same read-only command and compare the output. This before-and-after discipline is the difference between casual shell usage and reliable operations. Add commands that solved real incidents to your own notes, but keep them general enough that you can reuse them without copying unsafe host-specific values.
