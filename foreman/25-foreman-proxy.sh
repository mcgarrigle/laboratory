#!/bin/bash

source 00-environment.sh

function yaml {
  TEXT=$(cat $1 | sed 's/^--- //')
  echo $TEXT
}

CONSUMER_KEY=$(yaml /var/lib/puppet/foreman_cache_data/oauth_consumer_key)
CONSUMER_SECRET=$(yaml /var/lib/puppet/foreman_cache_data/oauth_consumer_secret)

foreman-installer \
  --enable-foreman-proxy \
  --foreman-proxy-tftp=true \
  --foreman-proxy-tftp-servername="${FOR_ADDRESS}" \
  --foreman-proxy-dhcp=true \
  --foreman-proxy-dhcp-interface="${ETH0}" \
  --foreman-proxy-dhcp-gateway= \
  --foreman-proxy-dhcp-nameservers="${FOR_ADDRESS}" \
  --foreman-proxy-dns=true \
  --foreman-proxy-dns-interface="${ETH0}" \
  --foreman-proxy-dns-zone="${DOMAIN}" \
  --foreman-proxy-dns-reverse="${REVERSE}" \
  --foreman-proxy-dns-forwarders="${DNS0}" \
  --foreman-proxy-foreman-base-url="${FOR_URL}" \
  --foreman-proxy-oauth-consumer-key="${CONSUMER_KEY}" \
  --foreman-proxy-oauth-consumer-secret="${CONSUMER_SECRET}"

# Setup wildcard auto-signing

echo "*" > /etc/puppet/autosign.conf

hammer subnet create --name "LOCAL" \
  --boot-mode "Static" \
  --network "${NETBASE}" \
  --mask "${NETMASK}" \
  --from "10.0.30.200" \
  --to "10.0.30.250" \
  --domains "${DOMAIN}" \
  --ipam "None"

