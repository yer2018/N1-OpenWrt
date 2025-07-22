#!/bin/bash

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
