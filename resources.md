# Resources

## Official Documentation

Use vendor documentation first when preparing for production work. RHEL documentation, systemd man pages, kernel documentation, OpenSSH manuals, firewalld manuals, and upstream project guides are more reliable than random snippets. In a lab, community examples are useful, but production changes should be checked against the release actually installed on the host.

## Useful Local Commands

```bash
man systemctl
man firewalld.richlanguage
man sshd_config
man exports
man lvm
apropos audit
rpm -qd openssh-server
```

## Practice Strategy

Build small repeatable labs. Break and fix SSH, firewalld, DNS, NFS, storage mounts, and systemd units on purpose. Keep a notebook of symptoms and log messages. After each exercise, write a three sentence summary: what failed, what proved it, and what fixed it. This develops the practical pattern recognition that administrators need during incidents.

## Suggested Tools

Install tools such as `vim`, `tmux`, `lsof`, `strace`, `tcpdump`, `sysstat`, `bind-utils`, `nmap-ncat`, `policycoreutils-python-utils`, and `bash-completion` in the lab. Some are not installed by default, but they are common in enterprise troubleshooting.

## Operator Notes

Treat Resources as a controlled administrative change, not as a memory exercise. Read the command, state what object it changes, run it on a disposable lab host first, and record the before and after state. Enterprise Linux work is safest when every action can be explained later from logs, shell history, and a short ticket note. When your output differs from the examples, compare release versions, service names, SELinux mode, firewall zones, and whether NetworkManager or systemd is managing the component.
