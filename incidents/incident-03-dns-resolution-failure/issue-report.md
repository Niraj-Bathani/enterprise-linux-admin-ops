# Issue Report

## Summary

Applications fail with name resolution errors while IP connectivity works. The issue was reported by the operations team during a normal support window and affected a production-like Linux service managed by `NetworkManager`. Initial impact was limited, but the symptom had the potential to block administrative response or customer traffic if left unresolved.

## Impact

Affected users experienced failed access attempts, delayed work, and repeated retries. The service owner confirmed that no planned maintenance was in progress. The first responder opened a bridge, preserved logs, and avoided restarting unrelated services until evidence was collected.

## Observed Evidence

```text
systemd-resolved: DNSSEC validation failed for internal zone
```

## Initial Actions

The responder captured `systemctl status NetworkManager`, relevant `journalctl` output, network or filesystem state, and recent change records. The case was handled as an operations incident, meaning restoration came first, while root cause notes were preserved for later review.

## Operator Notes

Treat Issue Report as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.

## Validation Habit

A good administrator validates from two directions: the local system state and the client experience. Do not only check that a daemon is active; also test the socket, review the log, and confirm that persistence survives a reboot. This habit prevents temporary fixes from being mistaken for durable operations. Keep commands readable, prefer documented configuration files, and avoid destructive shortcuts unless a backup and rollback plan are already written.
