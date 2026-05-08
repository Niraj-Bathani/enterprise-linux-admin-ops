# Logs Quick Reference

## Purpose

Logs Quick Reference is a quick-reference guide for incident response on Linux systems. Troubleshooting is a disciplined loop: define the symptom, collect evidence, form a hypothesis, test one variable, and document the result. Skipping steps feels faster but often extends outages.

## Data To Collect

| Command | Typical use |
|---|---|
| `journalctl -p warning -b` | Inspect, configure, or validate the logs area in a repeatable way. |
| `tail -n 100 /var/log/messages` | Inspect, configure, or validate the logs area in a repeatable way. |
| `grep -i error /var/log/secure` | Inspect, configure, or validate the logs area in a repeatable way. |
| `logger "test message from lab"` | Inspect, configure, or validate the logs area in a repeatable way. |
| `ausearch -k identity_changes` | Inspect, configure, or validate the logs area in a repeatable way. |

## Example Collection

```bash
journalctl -p warning -b
tail -n 100 /var/log/messages
grep -i error /var/log/secure
logger "test message from lab"
ausearch -k identity_changes
```

## How To Think About Results

Look for the first failing layer. In a network case, name resolution may fail before routing is relevant. In a filesystem case, an application error may be caused by permissions, SELinux labels, quota, or a read-only remount. In a performance case, check whether the issue is saturation, latency, errors, or external dependency failure.

## Escalation Notes

Escalate with evidence instead of conclusions. Include timestamps, hostname, service name, recent changes, commands run, important logs, and impact. If you changed anything, include the exact command and whether it helped. Clear notes reduce repeated work and make root cause analysis possible after service is restored.
