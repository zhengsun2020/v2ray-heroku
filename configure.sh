#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v
curl -L -H "Cache-Control: no-cache" -o /tmp/v/v.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v/v.zip -d /tmp/v
install -m 755 /tmp/v/v2ray /usr/local/bin/v
install -m 755 /tmp/v/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v

# V2Ray new configuration
install -d /usr/local/etc/v
cat << EOF > /usr/local/etc/v/c.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
/usr/local/bin/v -config /usr/local/etc/v/c.json
sleep 15
rm -rf /usr/local/bin/v2ctl
rm -rf /usr/local/etc/v/c.json


