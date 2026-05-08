# Diagnosis

## Diagnostic Approach

The diagnosis started by proving the failure layer. The team checked whether the host was reachable, whether the service was running, whether configuration parsed cleanly, and whether logs showed a direct denial or resource error. This prevented guessing and kept the response focused.

## Commands Used

```bash
systemctl status NetworkManager
journalctl -u NetworkManager -b --no-pager | tail -50
ss -tulpen
getenforce
ausearch -m AVC -ts recent
```

## Findings

The important log line was:

```text
systemd-resolved: DNSSEC validation failed for internal zone
```

The message matched the reported symptom and pointed to a specific configuration, resource, or dependency. Related checks ruled out broad host failure, DNS-only failure, and unrelated package changes. The likely cause was resolver configuration pointed clients to an external DNS server that did not host the private zone.

## Operator Notes

Treat Diagnosis as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.

## Validation Habit

A good administrator validates from two directions: the local system state and the client experience. Do not only check that a daemon is active; also test the socket, review the log, and confirm that persistence survives a reboot. This habit prevents temporary fixes from being mistaken for durable operations. Keep commands readable, prefer documented configuration files, and avoid destructive shortcuts unless a backup and rollback plan are already written.
