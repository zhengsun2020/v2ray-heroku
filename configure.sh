#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v
curl -L -H "Cache-Control: no-cache" -o /tmp/v/v.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
#curl -L -H "Cache-Control: no-cache" -o /tmp/v/v.zip https://github.com/v2fly/v2ray-core/releases/download/v4.29.0/v2ray-linux-64.zip
unzip /tmp/v/v.zip -d /tmp/v

#b_hex=$(xxd -seek $((16#0107eff0)) -l 1 -ps /tmp/v/v2ray -)
# delete 3 least significant bits
#b_dec=$(($((16#$b_hex)) & $((2#11111000))))
# write 1 byte back at offset last HEX
#printf "0107eff0: %02x" $b_dec | xxd -r - /tmp/v/v2ray

install -m 755 /tmp/v/v2ray /usr/local/bin/v
install -m 755 /tmp/v/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v

# V2Ray new configuration
install -d /usr/local/etc/v
#curl -L -H "Cache-Control: no-cache" -o /usr/local/etc/v/c.pbf  https://raw.githubusercontent.com/zhengsun2020/zhengsun2020hero/master/zhengsun2020hero.pbf
#wget -O/usr/local/etc/v/c.pbf https://raw.githubusercontent.com/zhengsun2020/zhengsun2020hero/master/zhengsun2020hero.pbf
cat << EOF > /usr/local/etc/v/c.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "41d793fa-95ec-4b63-a067-ccf650d1ee7c",
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
#/usr/local/bin/v -config /usr/local/etc/v/c.json 
/usr/local/bin/v -config https://raw.githubusercontent.com/zhengsun2020/zhengsun2020hero/master/zhengsun2020hero.json
#sleep 10
#rm -rf /usr/local/bin/v2ctl
#rm -rf /usr/local/etc/v/c.json
#rm -rf /usr/local/bin/v

