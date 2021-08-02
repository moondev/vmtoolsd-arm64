#!/bin/bash
set -e
set -x

curl -L https://raw.githubusercontent.com/moondev/vmtoolsd-arm64/main/open-vm-tools-dev_11.3.0-1_arm64.bionic.deb > open-vm-tools-dev_11.3.0-1_arm64.bionic.deb

dpkg -i open-vm-tools-dev_11.3.0-1_arm64.bionic.deb
# dpkg -r open-vm-tools-dev
ldconfig -v

cat > /etc/systemd/system/vmtoolsd.service << EOF
[Unit]
Description=Service for virtual machines hosted on VMware
Documentation=http://github.com/vmware/open-vm-tools
After=network-online.target

[Service]
ExecStart=/usr/local/bin/vmtoolsd
Restart=always
TimeoutStopSec=5

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable vmtoolsd.service
systemctl start vmtoolsd.service
systemctl status vmtoolsd.service