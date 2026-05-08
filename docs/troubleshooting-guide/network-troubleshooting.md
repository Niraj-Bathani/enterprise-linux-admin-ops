# Network Troubleshooting

## Purpose

Network Troubleshooting is a quick-reference guide for incident response on Linux systems. Troubleshooting is a disciplined loop: define the symptom, collect evidence, form a hypothesis, test one variable, and document the result. Skipping steps feels faster but often extends outages.

## Data To Collect

| Command | Typical use |
|---|---|
| `ip addr show` | Inspect, configure, or validate the network area in a repeatable way. |
| `ip route show` | Inspect, configure, or validate the network area in a repeatable way. |
| `nmcli device status` | Inspect, configure, or validate the network area in a repeatable way. |
| `nmcli connection show` | Inspect, configure, or validate the network area in a repeatable way. |
| `ss -tulpen` | Inspect, configure, or validate the network area in a repeatable way. |

## Example Collection

```bash
ip addr show
ip route show
nmcli device status
nmcli connection show
ss -tulpen
```

## How To Think About Results

Look for the first failing layer. In a network case, name resolution may fail before routing is relevant. In a filesystem case, an application error may be caused by permissions, SELinux labels, quota, or a read-only remount. In a performance case, check whether the issue is saturation, latency, errors, or external dependency failure.

## Escalation Notes

Escalate with evidence instead of conclusions. Include timestamps, hostname, service name, recent changes, commands run, important logs, and impact. If you changed anything, include the exact command and whether it helped. Clear notes reduce repeated work and make root cause analysis possible after service is restored.
