
function uppercase {
  echo $1 | awk '{print toupper($0)}'
}

export PASSWORD="letmein"
export DOMAIN="foo.local"
export REALM=$(uppercase $DOMAIN)
export FOR_SERVER="foreman.${DOMAIN}"
export IPA_SERVER="ipa.${DOMAIN}.local"
export FOR_ADDRESS="10.0.30.10"
export IPA_ADDRESS="10.0.30.11"
export IPA1="${IPA_ADDRESS}"
export DNS1="${IPA_ADDRESS}"
export NETWORK="10.0.30.0/24"
export REVERSE="30.0.10.in-addr.arpa"
export IPRANGE="10.0.30.200 10.0.30.250"
export ETH0=$(ip link |awk '/^2:/ { sub(/:/,"",$2); print $2 }')
export ETH1=$(ip link |awk '/^3:/ { sub(/:/,"",$2); print $2 }')
