# OOM Killer

## Purpose

OOM Killer is a quick-reference guide for incident response on Linux systems. Troubleshooting is a disciplined loop: define the symptom, collect evidence, form a hypothesis, test one variable, and document the result. Skipping steps feels faster but often extends outages.

## Data To Collect

| Command | Typical use |
|---|---|
| `ps -eo pid,ppid,user,stat,comm,%cpu,%mem --sort=-%cpu \| head` | Inspect, configure, or validate the process area in a repeatable way. |
| `top -b -n1 \| head -20` | Inspect, configure, or validate the process area in a repeatable way. |
| `nice -n 10 command` | Inspect, configure, or validate the process area in a repeatable way. |
| `renice 5 -p 1234` | Inspect, configure, or validate the process area in a repeatable way. |
| `kill -TERM 1234` | Inspect, configure, or validate the process area in a repeatable way. |

## Example Collection

```bash
ps -eo pid,ppid,user,stat,comm,%cpu,%mem --sort=-%cpu | head
top -b -n1 | head -20
nice -n 10 command
renice 5 -p 1234
kill -TERM 1234
```

## How To Think About Results

Look for the first failing layer. In a network case, name resolution may fail before routing is relevant. In a filesystem case, an application error may be caused by permissions, SELinux labels, quota, or a read-only remount. In a performance case, check whether the issue is saturation, latency, errors, or external dependency failure.

## Escalation Notes

Escalate with evidence instead of conclusions. Include timestamps, hostname, service name, recent changes, commands run, important logs, and impact. If you changed anything, include the exact command and whether it helped. Clear notes reduce repeated work and make root cause analysis possible after service is restored.
