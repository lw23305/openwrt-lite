#!/bin/bash

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

# 强制切换内核版本5.10/5.15/5.4/6.1
sed -i "s/KERNEL_PATCHVER:=*.*/KERNEL_PATCHVER:=5.15/g" target/linux/x86/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.15/g" target/linux/x86/Makefile

# ssr
# git clone --depth=1 -b main https://github.com/fw876/helloworld package/luci-app-ssr-plus
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
# git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall

# samba4菜单调整
sed -i '/samba4/s/^/#/' package/lean/default-settings/files/zzz-default-settings

./scripts/feeds update -a
./scripts/feeds install -a
