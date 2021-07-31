#!/bin/bash
set -e
set -x

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
