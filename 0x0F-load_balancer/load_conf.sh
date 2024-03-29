#!/usr/bin/env bash
# Install and configure HAproxy on your lb-01 server
# Configure HAproxy with version equal or greater than 1.5 so that it send traffic to web-01 and web-02
# Distribute requests using a roundrobin algorithm
# Make sure that HAproxy can be managed via an init script
# Make sure that your servers are configured with the right hostnames: [STUDENT_ID]-web-01 and [STUDENT_ID]-web-02
# The value of the custom HTTP header must be the hostname of the server Nginx is running on.

# First, install the load balanecer

sudo apt-get -y update
sudo apt-get -y install haproxy

# allow the use of the lb_01
#echo "ENABLED=1" >> /etc/default/haproxy

#cp /etc/haproxy/haproxy.cfg /etc/haproxy/original.cfg

# set the lb_01 with the required parameters
sudo echo "
global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        stats socket /run/haproxy/admin.sock mode 660 level admin
        stats timeout 30s
        user haproxy
        group haproxy
        daemon

        # Default SSL material locations
        ca-base /etc/ssl/certs
        crt-base /etc/ssl/private

        # Default ciphers to use on SSL-enabled listening sockets.
        # For more information, see ciphers(1SSL). This list is from:
        #  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
        ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
        ssl-default-bind-options no-sslv3

defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

frontend front-http
        bind *:80
        reqadd X-Forwarded-Proto:\ http
        default_backend www-backend

frontend front-https
        bind *:443 ssl crt /etc/haproxy/certs/www.onthebeat.tech.pem
        reqadd X-Forwarded-Proto:\ https
        default_backend www-backend

backend www-backend
        http-request redirect scheme https code 301 unless { ssl_fc }
        balance roundrobin
        server 2241-web-01  35.243.138.187 check
        server 2241-web-02  3.84.128.192 check

backend letsencrypt-backend
        server letsencrypt 127.0.0.1:54321" | sudo tee /etc/haproxy/haproxy.cfg

sudo service haproxy restart