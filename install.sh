#!/bin/sh

dpkg-statoverride --remove /usr/bin/crontab
dpkg-statoverride --remove /usr/lib/dbus-1.0/dbus-daemon-launch-helper

apt update
apt install -y \
    curl  \
    git \
    openssh-server \
    tmux \
    tzdata \
    vim

curl -fsSL https://tailscale.com/install.sh | sh

TZ=Asia/Shanghai
ln -nsf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone

sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config
sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config
