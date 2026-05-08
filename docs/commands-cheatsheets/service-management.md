# Service Management

## When To Use This Sheet

Use this cheat sheet during daily administration and timed lab work. It is intentionally compact, but every command should still be read before it is executed. Replace device names, users, paths, ports, and service names with values from your system. For commands that change state, record the original state first so that rollback is possible.

## Commands

| Command | Typical use |
|---|---|
| `systemctl status sshd` | Inspect, configure, or validate the service area in a repeatable way. |
| `systemctl enable --now firewalld` | Inspect, configure, or validate the service area in a repeatable way. |
| `journalctl -u sshd -b` | Inspect, configure, or validate the service area in a repeatable way. |
| `systemctl list-units --failed` | Inspect, configure, or validate the service area in a repeatable way. |
| `systemctl cat sshd` | Inspect, configure, or validate the service area in a repeatable way. |

## Patterns

```bash
systemctl status sshd
systemctl enable --now firewalld
journalctl -u sshd -b
systemctl list-units --failed
systemctl cat sshd
```

## Reading Output

Focus on names, states, exit codes, and timestamps. For example, a service that is `enabled` is not necessarily `active`; a route in the table does not prove DNS works; and an open port in `ss` may still be blocked by firewalld or SELinux. When the command has a terse output format, repeat it with a verbose flag or query the related journal.

## Safe Practice

Run read-only commands first, then perform one controlled change. After the change, repeat the same read-only command and compare the output. This before-and-after discipline is the difference between casual shell usage and reliable operations. Add commands that solved real incidents to your own notes, but keep them general enough that you can reuse them without copying unsafe host-specific values.
