# Process Management

## When To Use This Sheet

Use this cheat sheet during daily administration and timed lab work. It is intentionally compact, but every command should still be read before it is executed. Replace device names, users, paths, ports, and service names with values from your system. For commands that change state, record the original state first so that rollback is possible.

## Commands

| Command | Typical use |
|---|---|
| `ps -eo pid,ppid,user,stat,comm,%cpu,%mem --sort=-%cpu \| head` | Inspect, configure, or validate the process area in a repeatable way. |
| `top -b -n1 \| head -20` | Inspect, configure, or validate the process area in a repeatable way. |
| `nice -n 10 command` | Inspect, configure, or validate the process area in a repeatable way. |
| `renice 5 -p 1234` | Inspect, configure, or validate the process area in a repeatable way. |
| `kill -TERM 1234` | Inspect, configure, or validate the process area in a repeatable way. |

## Patterns

```bash
ps -eo pid,ppid,user,stat,comm,%cpu,%mem --sort=-%cpu | head
top -b -n1 | head -20
nice -n 10 command
renice 5 -p 1234
kill -TERM 1234
```

## Reading Output

Focus on names, states, exit codes, and timestamps. For example, a service that is `enabled` is not necessarily `active`; a route in the table does not prove DNS works; and an open port in `ss` may still be blocked by firewalld or SELinux. When the command has a terse output format, repeat it with a verbose flag or query the related journal.

## Safe Practice

Run read-only commands first, then perform one controlled change. After the change, repeat the same read-only command and compare the output. This before-and-after discipline is the difference between casual shell usage and reliable operations. Add commands that solved real incidents to your own notes, but keep them general enough that you can reuse them without copying unsafe host-specific values.
