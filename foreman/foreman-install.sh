#!/bin/bash

export PASSWORD="letmein"
export DOMAIN="foo.local"
export REALM="FOO.LOCAL"
export IPA_SERVER="ipa.foo.local"
export FOR_SERVER="foreman.foo.local"
export FOR_ADDRESS="10.0.30.10"
export IPA1="10.0.30.11"
export DNS1="10.0.30.11"
export NETWORK="10.0.30.0/24"
export REVERSE="30.0.10.in-addr.arpa."
export IPRANGE="10.0.30.200 10.0.30.250"

yum install -y centos-release-scl centos-release-scl-rh foreman-release-scl
yum install -y https://yum.theforeman.org/releases/1.14/el7/x86_64/foreman-release.rpm
yum install -y epel-release
yum install -y firewalld
yum install -y foreman-installer puppet

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

echo "DHCP/PXE interface = ${ETH0}"

hostnamectl set-hostname ${FOR_SERVER}

# stop host connections stalling on DNS lookup

echo "UseDNS no" >> /etc/ssh/sshd_config


echo "${FOR_ADDRESS} ${FOR_SERVER} foreman" >> /etc/hosts


#cat <<EOF > /etc/resolv.conf
#domain ${DOMAIN}
#nameserver ${DNS1}
#EOF

echo "Setting up Firewall Rules..."

systemctl start firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --permanent --add-port=81/tcp
firewall-cmd --permanent --add-port=69/tcp
firewall-cmd --permanent --add-port=67-69/udp
firewall-cmd --permanent --add-port=53/tcp
firewall-cmd --permanent --add-port=53/udp
firewall-cmd --permanent --add-port=8443/tcp
firewall-cmd --permanent --add-port=8140/tcp
firewall-cmd --reload
systemctl enable firewalld

echo "Running Foreman Installer..."

foreman-installer \
  --foreman-foreman-url="http://${FOR_SERVER}" \
  --foreman-configure-epel-repo=false \
  --foreman-configure-scl-repo=false \
  --enable-foreman-plugin-dhcp-browser \
  --enable-foreman-plugin-openscap \
  --enable-foreman-proxy-plugin-openscap \
  --foreman-admin-password=admin \
  --foreman-proxy-dhcp=true \
  --foreman-proxy-dhcp-interface="${ETH0}" \
  --foreman-proxy-dhcp-range="${IPRANGE}" \
  --foreman-proxy-dhcp-nameservers="${DNS1}" \
  --foreman-proxy-dhcp-pxeserver="${FOR_ADDRESS}" \
  --foreman-ipa-authentication=false

# Setup wildcard auto-signing

echo "*" > /etc/puppet/autosign.conf

