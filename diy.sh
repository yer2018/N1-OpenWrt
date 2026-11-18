#!/bin/bash

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-vantage/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP（FROM 192.168.1.1 CHANGE TO 10.10.10.1）
#sed -i 's/192.168.1.1/10.10.10.100/g' package/base-files/files/bin/config_generate

# Modify system hostname（FROM OpenWrt CHANGE TO OpenWrt-N1）
sed -i 's/ImmortalWrt/Phicomm-N1/g' package/base-files/files/bin/config_generate

# Replace the default software source
sed -i 's#mirrors.vsean.net#mirrors.tuna.tsinghua.edu.cn#g' package/lean/default-settings/files/zzz-default-settings

sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/\.apdisk\//\.apdisk\/\._*/g' feeds/packages/net/samba4/files/smb.conf.template

# Match the Rust toolchain used by the last successful 24.10 build.
sed -i \
	-e 's/^PKG_VERSION:=.*/PKG_VERSION:=1.94.0/' \
	-e 's/^PKG_HASH:=.*/PKG_HASH:=0b53ae34f5c0c3612cfe1de139f9167a018cd5737bc2205664fd69ba9b25f600/' \
	-e 's/--set=llvm.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' \
	feeds/packages/lang/rust/Makefile

# Add packages
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic
git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
git clone https://github.com/kenzok8/openwrt-honk.git /tmp/openwrt-honk
cp -a /tmp/openwrt-honk/honk package/honk
cp -a /tmp/openwrt-honk/luci-app-honk package/luci-app-honk
git clone https://github.com/kenzok8/small.git /tmp/openwrt-small
cp -a /tmp/openwrt-small/luci-app-mosdns package/luci-app-mosdns
cp -a /tmp/openwrt-small/mosdns package/mosdns
cp -a /tmp/openwrt-small/geo2txt package/geo2txt
cp -a /tmp/openwrt-small/v2ray-geodata package/v2ray-geodata
git clone https://github.com/kenzok8/openwrt-packages.git /tmp/openwrt-packages
for pkg in luci-app-adguardhome adguardhome luci-app-vantage luci-theme-vantage luci-app-subconverter luci-app-filebrowser filebrowser; do
	cp -a "/tmp/openwrt-packages/$pkg" "package/$pkg"
done
#git clone https://github.com/jerrykuku/luci-app-argon-config.git --depth=1 clone/luci-app-argon-config
#git clone https://github.com/jerrykuku/luci-theme-argon.git --depth=1 clone/luci-theme-argon
#git clone https://github.com/eamonxg/luci-theme-aurora package/luci-theme-aurora
#git clone https://github.com/eamonxg/luci-app-aurora-config package/luci-app-aurora-config


