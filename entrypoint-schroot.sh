#!/bin/sh

tailscaled -tun userspace-networking &

mkdir -p /run/sshd
sshd -D -e &

cron -f -P &

exec "$@"
