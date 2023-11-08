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
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#sed -i '$a src-git packages https://github.com/coolsnowwolf/packages
#sed -i '$a src-git luci https://github.com/coolsnowwolf/luci
#sed -i '$a src-git routing https://git.openwrt.org/feed/routing.git
#sed -i '$a src-git telephony https://git.openwrt.org/feed/telephony.git
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld
#sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages
git clone https://github.com/kenzok8/openwrt-packages.git package/kenzo
#git clone https://github.com/jiawm/luci-app-poweroff.git package/poweroff
#git clone https://github.com/linkease/nas-packages-luci package/nas #添加ddnsto和linkease

