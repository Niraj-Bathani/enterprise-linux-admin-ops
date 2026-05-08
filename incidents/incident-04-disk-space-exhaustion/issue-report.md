# Issue Report

## Summary

/var reaches 100 percent and logging stops. The issue was reported by the operations team during a normal support window and affected a production-like Linux service managed by `filesystem`. Initial impact was limited, but the symptom had the potential to block administrative response or customer traffic if left unresolved.

## Impact

Affected users experienced failed access attempts, delayed work, and repeated retries. The service owner confirmed that no planned maintenance was in progress. The first responder opened a bridge, preserved logs, and avoided restarting unrelated services until evidence was collected.

## Observed Evidence

```text
kernel: EXT4-fs warning: mounting fs with errors, running e2fsck is recommended
```

## Initial Actions

The responder captured `systemctl status filesystem`, relevant `journalctl` output, network or filesystem state, and recent change records. The case was handled as an operations incident, meaning restoration came first, while root cause notes were preserved for later review.

## Operator Notes

Treat Issue Report as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
