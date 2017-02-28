
export PASSWORD="letmein"
export DOMAIN="foo.local"
export REALM="FOO.LOCAL"
export IPA_SERVER="ipa.foo.local"
export FOR_SERVER="foreman.foo.local"
export IPA1="10.0.1.11"
export DNS1="10.0.1.11"
export NETWORK="10.0.1.0/24"
export REVERSE="1.0.10.in-addr.arpa."
export IPRANGE="10.0.1.200 10.0.1.250"

yum -y install epel-release
yum -y install https://yum.theforeman.org/releases/1.14/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer puppet

export INTERFACE=$(ip link |awk '/^2:/ { sub(/:/,"",$2); print $2 }')

cat <<EOF > /etc/resolv.conf
domain ${DOMAIN}
nameserver ${DNS1}
EOF


echo "Setting up Firewall Rules..."

systemctl start firewalld
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
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
--foreman-configure-epel-repo=false \
--foreman-configure-scl-repo=false \
--enable-foreman-plugin-dhcp-browser \
--enable-foreman-plugin-openscap \
--enable-foreman-proxy-plugin-openscap \
--foreman-admin-password=admin \
--foreman-proxy-dhcp=true \
--foreman-proxy-dhcp-interface="${INTERFACE}" \
--foreman-proxy-dhcp-range="${IPRANGE}" \
--foreman-proxy-dhcp-nameservers="${DNS1}" \
--foreman-ipa-authentication=false

# Setup wildcard auto-signing

echo "*" > /etc/puppet/autosign.conf

