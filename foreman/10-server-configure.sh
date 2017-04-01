#!/bin/bash

export PASSWORD="letmein"
export DOMAIN="foo.local"
export REALM="FOO.LOCAL"
export FOR_SERVER="foreman.foo.local"
export FOR_ADDRESS="10.0.30.10"
export IPA1="10.0.30.11"
export DNS1="10.0.30.11"
export NETWORK="10.0.30.0/24"
export REVERSE="30.0.10.in-addr.arpa."
export IPRANGE="10.0.30.200 10.0.30.250"

yum install -y firewalld vim httpd
yum install -y epel-release
yum install -y tinyproxy

export ETH0=$(ip link |awk '/^2:/ { sub(/:/,"",$2); print $2 }')
export ETH1=$(ip link |awk '/^3:/ { sub(/:/,"",$2); print $2 }')

sed -i 's/ONBOOT=no/ONBOOT=yes/' "/etc/sysconfig/network-scripts/ifcfg-${ETH0}"
sed -i 's/ONBOOT=no/ONBOOT=yes/' "/etc/sysconfig/network-scripts/ifcfg-${ETH1}"

cat <<EOF > "/etc/sysconfig/network-scripts/ifcfg-${ETH0}"
DEVICE=${ETH0}
BOOTPROTO=static
IPADDR="${FOR_ADDRESS}"
NETMASK="255.255.255.0"
ONBOOT=yes
EOF

ifup ${ETH0}

hostnamectl set-hostname ${FOR_SERVER}

# stop host connections stalling on DNS lookup

echo "UseDNS no" >> /etc/ssh/sshd_config

echo "${FOR_ADDRESS} ${FOR_SERVER} foreman" >> /etc/hosts

