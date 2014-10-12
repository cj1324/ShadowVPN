#!/bin/sh

# example client up script for darwin
# will be executed when client is up

# all key value pairs in ShadowVPN config file will be passed to this script
# as environment variables, except password

# user-defined variables
local_tun_ip=$tun_local_ip
remote_tun_ip=$tun_remote_ip
dns_server=8.8.8.8

# get current gateway
orig_gw=$(netstat -nr | grep --color=never '^default' | grep -v 'utun' | sed 's/default *\([0-9\.]*\) .*/\1/' | head -1)
route add -net $server $orig_gw

# change routing table
echo changing default route
route add -net 128.0.0.0 $remote_tun_ip -netmask 128.0.0.0
route add -net 0.0.0.0 $remote_tun_ip -netmask 128.0.0.0
route add -net $remote_tun_ip -netmask 255.255.255.255 -interface $intf
echo default route changed to $remote_tun_ip

# change dns server
networksetup -setdnsservers Wi-Fi $dns_server

echo $0 done
