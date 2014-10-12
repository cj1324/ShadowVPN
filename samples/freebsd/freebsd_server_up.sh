#!/bin/sh

# example server up script
# will be executed when server is up

# all key value pairs in ShadowVPN config file will be passed to this script
# as environment variables, except password

# turn on IP forwarding
sysctl -w net.inet.ip.forwarding=1

# route table need!
route add -net $tun_local_ip -netmask $tun_netmask $tun_local_ip

# copy pf.conf to /etc 
# pfctl -F all -f /etc/pf.conf

# show pf nat rule
pfctl -s nat

echo $0 done
