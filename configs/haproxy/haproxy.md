# Production-style HAProxy example for training
global
    log /dev/log local0
    chroot /var/lib/haproxy
    pidfile /run/haproxy.pid
    maxconn 4096
    user haproxy
    group haproxy
    daemon

defaults
    mode http
    log global
    option httplog
    option dontlognull
    timeout connect 5s
    timeout client 50s
    timeout server 50s

frontend http_in
    bind *:80
    acl health path /health
    http-request return status 200 content-type text/plain string ok if health
    default_backend app_pool

backend app_pool
    balance roundrobin
    option httpchk GET /health
    server app01 10.10.10.21:80 check
    server app02 10.10.10.22:80 check
