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

# Add hideck (HiDeck modem management, prebuilt musl-static binary from upstream release)
HIDECK_VERSION=2.1.29
HIDECK_SHA256=8666c6e69c9163485988b35b2f324ff3b3d35fc56d09bbc258ed5ebe586fda84
mkdir -p package/hideck/files
for f in Makefile files/config.yaml files/hideck.init files/modem-voice.txt; do
  curl -fsSL -o "package/hideck/$f" "https://raw.githubusercontent.com/yibaiba/hideck/v${HIDECK_VERSION}/packaging/openwrt/hideck/$f"
done
# Pin version and binary hash as Makefile defaults so plain `make` works without extra vars
sed -i "s|^HIDECK_VERSION?=.*|HIDECK_VERSION?=${HIDECK_VERSION}|" package/hideck/Makefile
sed -i "s|^PKG_HASH:=\\\$(HIDECK_BINARY_SHA256)|HIDECK_BINARY_SHA256?=${HIDECK_SHA256}\nPKG_HASH:=\\\$(HIDECK_BINARY_SHA256)|" package/hideck/Makefile
# OpenWrt staging root may use a symlink for /var; hideck.init creates runtime state on start.
sed -i 's# [$](1)/var/lib/hideck##' package/hideck/Makefile

