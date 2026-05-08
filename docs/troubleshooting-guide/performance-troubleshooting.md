# Performance Troubleshooting

## Purpose

Performance Troubleshooting is a quick-reference guide for incident response on Linux systems. Troubleshooting is a disciplined loop: define the symptom, collect evidence, form a hypothesis, test one variable, and document the result. Skipping steps feels faster but often extends outages.

## Data To Collect

| Command | Typical use |
|---|---|
| `uptime` | Inspect, configure, or validate the performance area in a repeatable way. |
| `mpstat 1 5` | Inspect, configure, or validate the performance area in a repeatable way. |
| `free -h` | Inspect, configure, or validate the performance area in a repeatable way. |
| `iostat -xz 1 5` | Inspect, configure, or validate the performance area in a repeatable way. |
| `sar -n DEV 1 5` | Inspect, configure, or validate the performance area in a repeatable way. |

## Example Collection

```bash
uptime
mpstat 1 5
free -h
iostat -xz 1 5
sar -n DEV 1 5
```

## How To Think About Results

Look for the first failing layer. In a network case, name resolution may fail before routing is relevant. In a filesystem case, an application error may be caused by permissions, SELinux labels, quota, or a read-only remount. In a performance case, check whether the issue is saturation, latency, errors, or external dependency failure.

## Escalation Notes

Escalate with evidence instead of conclusions. Include timestamps, hostname, service name, recent changes, commands run, important logs, and impact. If you changed anything, include the exact command and whether it helped. Clear notes reduce repeated work and make root cause analysis possible after service is restored.
