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
#

# package/emortal/default-settings/files/99-default-settings

# Modify default IP
#sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.3.2/g' package/base-files/files/bin/config_generate
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
sed -i '/firewall.user/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/REVISION/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/DESCRIPTION/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/filter_aaaa/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/cachesize/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/min_cache_ttl/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/start/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/limit/d' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/config dnsmasq/r files/dnsmasq.conf' package/network/services/dnsmasq/files/dhcp.conf
sed -i '/config dhcp lan/r files/dhcp.conf' package/network/services/dnsmasq/files/dhcp.conf
