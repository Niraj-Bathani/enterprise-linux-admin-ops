# Prevention

## Preventive Measures

To prevent recurrence, add a pre-change and post-change checklist for `filesystem`. The checklist should include configuration syntax validation, service restart or reload behavior, log review, firewall and SELinux checks where applicable, and one client-side functional test.

## Monitoring

Create alerts for the symptom, not only the daemon state. Useful alerts include repeated authentication or mount failures, failed health checks, degraded arrays, high memory pressure, disk capacity thresholds, or service port conflicts depending on the service. Alerts should include the hostname, service name, recent log excerpt, and a link to the runbook.

## Operational Control

Require changes to include rollback instructions. Store configuration in version control, use peer review for risky service changes, and record exceptions with expiration dates. Preventive work is successful only when the next responder can identify the same failure faster and with less uncertainty.

## Operator Notes

Treat Prevention as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.

## Validation Habit

A good administrator validates from two directions: the local system state and the client experience. Do not only check that a daemon is active; also test the socket, review the log, and confirm that persistence survives a reboot. This habit prevents temporary fixes from being mistaken for durable operations. Keep commands readable, prefer documented configuration files, and avoid destructive shortcuts unless a backup and rollback plan are already written.
