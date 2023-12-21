#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall

# Argon主题 
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/lean/luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# 取消主题默认设置
find package/luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns

# MosDNS
svn export https://github.com/sbwml/luci-app-mosdns/trunk/luci-app-mosdns package/luci-app-mosdns
svn export https://github.com/sbwml/luci-app-mosdns/trunk/mosdns package/mosdns
# JD
git clone --depth=1 https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
# 调整 samba4 到 服务 菜单
sed -i 's/nas/services/g; s/nas/Services/g' feeds/luci/applications/luci-app-samba4/luasrc/controller/samba4.lua
sed -i 's/nas/services/g' feeds/luci/applications/luci-app-samba4/luasrc/view/samba4/samba4_status.htm
# 取消对 samba4 的菜单调整
sed -i '/samba4/s/^/#/' package/lean/default-settings/files/zzz-default-settings
./scripts/feeds update -a
./scripts/feeds install -a

