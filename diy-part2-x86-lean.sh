#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)


# 切换ramips内核为 5.10
sed -i 's/5.15/5.10/g' ./target/linux/ramips/Makefile

# 切换x86内核为 5.10
sed -i 's/5.15/5.10/g' ./target/linux/x86/Makefile

#添加温度显示
sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template

#修改版本号
modelmark=R`TZ=UTC-8 date +%Y-%m-%d -d +"1"days`''
sed -i "s/DISTRIB_REVISION='R[0-9]*\.[0-9]*\.[0-9]*/DISTRIB_REVISION='$modelmark/g" ./package/lean/default-settings/files/zzz-default-settings

# 修改版本号-tty
sed -i "s/timestamp/Built on '$(TZ=UTC-8 date +%Y-%m-%d -d +"1"days)'/g" ./package/base-files/files/etc/banner

# Change Argon Theme
# rm -rf ./package/lean/luci-theme-argon 
rm -rf ./feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git ./package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/luci-app-argon-config

# Change default BackGround img
# rm ./package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
wget -O ./package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg https://github.com/jiawm/My-OpenWrt/raw/main/BackGround/2.jpg
svn co https://github.com/xylz0928/luci-mod/trunk/feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons ./package/lucimod
mv package/lucimod/* feeds/luci/modules/luci-base/htdocs/luci-static/resources/icons/


# Change default theme
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile


# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了，其他的不要动
sed -i 's/192.168.1.1/192.168.100.102/g' package/base-files/files/bin/config_generate

# Remove the default apps 移除默认编译app，不是移除app
sed -i 's/luci-app-zerotier //g' target/linux/x86/Makefile
sed -i 's/luci-app-unblockmusic //g' target/linux/x86/Makefile
sed -i 's/luci-app-xlnetacc //g' target/linux/x86/Makefile
sed -i 's/luci-app-jd-dailybonus //g' target/linux/x86/Makefile
sed -i 's/luci-app-ipsec-vpnd //g' target/linux/x86/Makefile
sed -i 's/luci-app-adbyby-plus //g' target/linux/x86/Makefile
sed -i 's/luci-app-sfe //g' target/linux/x86/Makefile
sed -i 's/luci-app-uugamebooster//g' target/linux/x86/Makefile
sed -i 's/-luci-app-flowoffload//g' target/linux/x86/Makefile
sed -i 's/kmod-drm-amdgpu \\/kmod-drm-amdgpu/g' target/linux/x86/Makefile

# remove lede linked luci-app-pushbot k大包自带pushbot
rm -rf ./package/lean/luci-app-pushbot
#删除k大app
rm -rf ./package/kenzo/luci-app-adguardhome
rm -rf ./package/kenzo/adguardhome

#添加281677160包
svn co https://github.com/281677160/openwrt-package/trunk/luci-app-adguardhome ./package/luci-app-adguardhome
chmod -R 755 ./package/luci-app-adguardhome/*
svn co https://github.com/281677160/openwrt-package/trunk/adguardhome ./package/adguardhome
chmod -R 755 ./package/adguardhome/*

# 注释默认防火墙规则
#sed -i "s/echo 'iptables/echo '# iptables/g" ./package/lean/default-settings/files/zzz-default-settings
#sed -i "s/echo '\[ -n/echo '# \[ -n/g" ./package/lean/default-settings/files/zzz-default-settings


# Add WOL Plus
svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus ./package/luci-app-wolplus
chmod -R 755 ./package/luci-app-wolplus/*

#  git lua-maxminddb 依赖
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/lean/lua-maxminddb

# Add Hello World
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/lean/luci-app-vssr

# Add Passwall
# git clone https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall

# Add luci-app-socat
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-socat ./package/luci-app-socat
# chmod -R 755 ./package/luci-app-socat/*
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/socat ./package/socat
# chmod -R 755 ./package/socat/*

# Add OpenClash
# git clone -b master https://github.com/vernesong/OpenClash.git package/OpenClash

#以下添加sirpdboy管控内容 Add luci-app-control-weburl
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-weburl ./package/luci-app-control-weburl
# chmod -R 755 ./package/luci-app-control-weburl/*


# Add luci-app-wrtbwmon
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon ./package/luci-app-wrtbwmon
# chmod -R 755 ./package/luci-app-wrtbwmon/*
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon ./package/wrtbwmon
# chmod -R 755 ./package/wrtbwmon/*



#以下为旧版代码，目前不再使用。
# Add luci-app-cpulimit
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-cpulimit ./package/luci-app-cpulimit
#chmod -R 755 ./package/luci-app-cpulimit/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/cpulimit ./package/cpulimit
#chmod -R 755 ./package/cpulimit/*

# Add S大修改的网速控制（主要在管控菜单下），本固件不使用S大，使用K大eqos，故不删除K大默认eqos
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-eqos ./package/luci-app-eqos
#chmod -R 755 ./package/luci-app-eqos/*

#Add luci-app-dockerman
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-dockerman ./package/luci-app-dockerman
#chmod -R 755 ./package/luci-app-dockerman/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/dockerman ./package/dockerman
#chmod -R 755 ./package/dockerman/*

#删除与K大重复app 使用k大，不删除
#rm -rf ./package/kenzo/luci-app-eqos #k大的在网络下

# 添加温度显示
# sed -i 's/invalid/# invalid/g' package/network/services/samba36/files/smb.conf.template



#更换默认主题为opentopd，并删除bootstrap主题 可以使用
#sed -i 's#luci-theme-bootstrap#luci-theme-opentopd#g' feeds/luci/collections/luci/Makefile
#sed -i 's/bootstrap/opentopd/g' feeds/luci/modules/luci-base/root/etc/config/luci

#删除lean大集成的旧版argon主题，更换为新版argon主题#Change Argon Theme 
#rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

#添加argon主题设置插件
#git clone https://github.com/jerrykuku/luci-app-argon-config.git ./package/lean/luci-app-argon-config

#替换为sirpdboy中文版netdata
#rm -rf ./package/lean/luci-app-netdata 
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata ./package/luci-app-netdata
#chmod -R 755 ./package/luci-app-netdata/*
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/netdata ./package/netdata
#chmod -R 755 ./package/netdata/*

#Add 添加kiddin9的ikoolproxy
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-ikoolproxy ./package/luci-app-ikoolproxy
#chmod -R 755 ./package/luci-app-ikoolproxy/*
#svn co https://github.com/kiddin9/openwrt-packages/trunk/ikoolproxy ./package/ikoolproxy
#chmod -R 755 ./package/ikoolproxy/*

#Add luci-app-dnsfilter
#svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-dnsfilter ./package/luci-app-dnsfilter
#chmod -R 755 ./package/luci-app-dnsfilter/*

