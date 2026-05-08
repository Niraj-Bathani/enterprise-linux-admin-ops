# User Limits

## Purpose

User Limits is a quick-reference guide for incident response on Linux systems. Troubleshooting is a disciplined loop: define the symptom, collect evidence, form a hypothesis, test one variable, and document the result. Skipping steps feels faster but often extends outages.

## Data To Collect

| Command | Typical use |
|---|---|
| `id alice` | Inspect, configure, or validate the users area in a repeatable way. |
| `getent passwd alice` | Inspect, configure, or validate the users area in a repeatable way. |
| `useradd -m alice` | Inspect, configure, or validate the users area in a repeatable way. |
| `passwd -S alice` | Inspect, configure, or validate the users area in a repeatable way. |
| `usermod -aG wheel alice` | Inspect, configure, or validate the users area in a repeatable way. |

## Example Collection

```bash
id alice
getent passwd alice
useradd -m alice
passwd -S alice
usermod -aG wheel alice
```

## How To Think About Results

Look for the first failing layer. In a network case, name resolution may fail before routing is relevant. In a filesystem case, an application error may be caused by permissions, SELinux labels, quota, or a read-only remount. In a performance case, check whether the issue is saturation, latency, errors, or external dependency failure.

## Escalation Notes

Escalate with evidence instead of conclusions. Include timestamps, hostname, service name, recent changes, commands run, important logs, and impact. If you changed anything, include the exact command and whether it helped. Clear notes reduce repeated work and make root cause analysis possible after service is restored.
