#!/bin/bash

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-aurora/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP（FROM 192.168.1.1 CHANGE TO 10.10.10.1）
#sed -i 's/192.168.1.1/10.10.10.100/g' package/base-files/files/bin/config_generate

# Modify system hostname（FROM OpenWrt CHANGE TO OpenWrt-N1）
sed -i 's/ImmortalWrt/Phicomm-N1/g' package/base-files/files/bin/config_generate

# Replace the default software source
sed -i 's#mirrors.vsean.net#mirrors.tuna.tsinghua.edu.cn#g' package/lean/default-settings/files/zzz-default-settings

sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/\.apdisk\//\.apdisk\/\._*/g' feeds/packages/net/samba4/files/smb.conf.template

# Add packages
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic
git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
#git clone https://github.com/jerrykuku/luci-app-argon-config.git --depth=1 clone/luci-app-argon-config
#git clone https://github.com/jerrykuku/luci-theme-argon.git --depth=1 clone/luci-theme-argon
git clone https://github.com/eamonxg/luci-theme-aurora package/luci-theme-aurora
git clone https://github.com/eamonxg/luci-app-aurora-config package/luci-app-aurora-config

