#!/bin/sh

VERSION="2.11.0"
USR="admin"
PWD="123456"

curl -sLO https://github.com/ginuerzh/gost/releases/download/v${VERSION}/gost-linux-amd64-${VERSION}.gz
gzip -d gost-linux-amd64-${VERSION}.gz
mv gost-linux-amd64-${VERSION} /usr/local/bin/gost
chmod +x /usr/local/bin/gost

cat>/etc/systemd/system/gost-proxy.service<<EOF
[Unit]
Description=Proxy
After=network.target
[Service]
Type=simple
ExecStart=/usr/local/bin/gost -L=ss+mws://chacha20:${PWD}@:8888 -L=socks5://${USR}:${PWD}@:9999
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

systemctl start gost-proxy.service