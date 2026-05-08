# Root Cause

## Root Cause Statement

The root cause was one virtual disk failed and the spare was not automatically added. The condition was introduced by a routine administrative or deployment change that did not include enough validation for the affected service. The technical failure was visible in the log line below, which directly explains the symptom.

```text
md/raid1:md0: Disk failure on sdb1, disabling device
```

## Contributing Factors

Contributing factors included incomplete post-change checks, missing alert context, and insufficient runbook detail for the service owner. The issue was not treated as an isolated command failure; it was treated as a process gap around change validation and operational readiness.

## Detection

The incident was detected by users or monitoring after the failed state was already active. Earlier detection would have been possible with a health check that validates the real client path rather than only checking process state.

## Operator Notes

Treat Root Cause as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.

## Validation Habit

A good administrator validates from two directions: the local system state and the client experience. Do not only check that a daemon is active; also test the socket, review the log, and confirm that persistence survives a reboot. This habit prevents temporary fixes from being mistaken for durable operations. Keep commands readable, prefer documented configuration files, and avoid destructive shortcuts unless a backup and rollback plan are already written.
