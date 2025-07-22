#!/bin/bash

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP（FROM 192.168.1.1 CHANGE TO 10.10.10.1）
#sed -i 's/192.168.1.1/10.10.10.100/g' package/base-files/files/bin/config_generate

# Modify system hostname（FROM OpenWrt CHANGE TO OpenWrt-N1）
sed -i 's/immortalwrt/Phicomm-N1/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#mirrors.vsean.net#mirrors.bfsu.edu.cn#g' package/lean/default-settings/files/zzz-default-settings

sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/\.apdisk\//\.apdisk\/\._*/g' feeds/packages/net/samba4/files/smb.conf.template

# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
#git clone https://github.com/xiaorouji/openwrt-passwall --depth=1 clone/passwall
git clone https://github.com/vernesong/OpenClash.git --depth=1 clone/openclash
git clone https://github.com/jerrykuku/luci-app-argon-config.git --depth=1 clone/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-theme-argon.git --depth=1 clone/luci-theme-argon

# Update packages
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/themes/luci-theme-argon
cp -rf clone/amlogic/luci-app-amlogic clone/passwall/luci-app-passwall clone/openclash/luci-app-openclash clone/luci-app-argon-config clone/luci-theme-argon feeds/luci/applications/

# Clean packages
rm -rf clone
