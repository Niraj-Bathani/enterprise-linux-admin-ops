# Lessons Learned

## What Went Well

The responder collected logs before making broad changes, focused on the failing layer, and restored service with a targeted action. This reduced risk and preserved evidence for root cause analysis.

## What Could Improve

The team needed clearer validation steps for `NetworkManager`. A process being active was not enough evidence that users could complete their workflow. The runbook should show exact commands, expected output, and common log patterns.

## Follow Up Tasks

- Update the runbook with the log pattern: `systemd-resolved: DNSSEC validation failed for internal zone`.
- Add a functional monitoring check that matches the user-visible path.
- Review recent changes for similar risk on peer systems.
- Practice the diagnosis in a lab VM so junior administrators can recognize the pattern.

## Takeaway

The main lesson is that incidents are solved by evidence. A small amount of disciplined collection at the beginning makes the fix faster, the root cause clearer, and the prevention work more realistic.

## Operator Notes

Treat Lessons Learned as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
