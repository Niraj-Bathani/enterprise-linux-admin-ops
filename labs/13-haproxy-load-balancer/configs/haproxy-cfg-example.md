#---------------------------------------------------------------------
# Global Settings
#---------------------------------------------------------------------

global
    log         127.0.0.1 local2
    chroot      /var/lib/haproxy
    pidfile     /run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    stats socket /run/haproxy/admin.sock mode 660 level admin

    ssl-default-bind-ciphers PROFILE=SYSTEM
    ssl-default-server-ciphers PROFILE=SYSTEM

#---------------------------------------------------------------------
# Default Settings
#---------------------------------------------------------------------

defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           60s
    timeout connect         10s
    timeout client          60s
    timeout server          60s
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

#---------------------------------------------------------------------
# Frontend Configuration
#---------------------------------------------------------------------

frontend production-http
    bind *:80
    mode http

    option forwardfor
    http-request set-header X-Forwarded-Proto http

    acl is_healthcheck path /health
    use_backend healthcheck-backend if is_healthcheck

    default_backend apache-backend-pool

#---------------------------------------------------------------------
# Backend Web Server Pool
#---------------------------------------------------------------------

backend apache-backend-pool
    mode http
    balance roundrobin

    option httpchk GET /

    server web01 192.168.1.101:80 check inter 5s fall 3 rise 2
    server web02 192.168.1.102:80 check inter 5s fall 3 rise 2
    server web03 192.168.1.103:80 check backup

#---------------------------------------------------------------------
# Healthcheck Backend
#---------------------------------------------------------------------

backend healthcheck-backend
    mode http

    http-request return status 200 \
        content-type text/plain \
        string "HAProxy healthy"

#---------------------------------------------------------------------
# Statistics Dashboard
#---------------------------------------------------------------------

listen haproxy-stats
    bind *:8404
    mode http

    stats enable
    stats uri /stats
    stats refresh 10s

    stats auth admin:StrongPassword123

#---------------------------------------------------------------------
# HTTPS Frontend Example
#---------------------------------------------------------------------

frontend production-https
    bind *:443 ssl crt /etc/pki/tls/private/haproxy.pem

    mode http

    option forwardfor
    http-request set-header X-Forwarded-Proto https

    default_backend apache-backend-pool

#---------------------------------------------------------------------
# TCP Load Balancing Example
#---------------------------------------------------------------------

frontend mysql-tcp
    bind *:3306
    mode tcp

    default_backend mysql-backend

backend mysql-backend
    mode tcp
    balance leastconn

    server db01 192.168.1.201:3306 check
    server db02 192.168.1.202:3306 check backup

#---------------------------------------------------------------------
# Logging Recommendations
#---------------------------------------------------------------------

# rsyslog example:
#
# module(load="imudp")
# input(type="imudp" port="514")
#
# local2.*    /var/log/haproxy.log

#---------------------------------------------------------------------
# SELinux Notes
#---------------------------------------------------------------------

# semanage port -a -t http_port_t -p tcp 8404
# setsebool -P haproxy_connect_any on

#---------------------------------------------------------------------
# Validation Commands
#---------------------------------------------------------------------

# haproxy -c -f /etc/haproxy/haproxy.cfg
# systemctl restart haproxy
# systemctl status haproxy
# ss -tulpn | grep haproxy
# curl http://localhost
# curl http://localhost:8404/stats

#---------------------------------------------------------------------
# Enterprise Operational Notes
#---------------------------------------------------------------------

# - Use active health checks for backend validation
# - Protect stats dashboard with authentication
# - Prefer HTTPS for production traffic
# - Monitor backend server health continuously
# - Use SELinux enforcing mode in production
# - Audit HAProxy logs regularly
# - Configure redundancy for load balancer nodes
