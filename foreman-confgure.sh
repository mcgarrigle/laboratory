foreman-installer \
  --enable-foreman-proxy \
  --foreman-proxy-tftp=true \
  --foreman-proxy-tftp-servername=10.0.30.10 \
  --foreman-proxy-dhcp=true \
  --foreman-proxy-dhcp-interface=enp0s3 \
  --foreman-proxy-dhcp-gateway= \
  --foreman-proxy-dhcp-nameservers="10.0.30.10" \
  --foreman-proxy-dns=true \
  --foreman-proxy-dns-interface=enp0s3 \
  --foreman-proxy-dns-zone=foo.local \
  --foreman-proxy-dns-reverse=30.0.10.in-addr.arpa \
  --foreman-proxy-dns-forwarders=10.0.1.1 \
  --foreman-proxy-foreman-base-url=https://foreman.foo.local \
  --foreman-proxy-oauth-consumer-key=85cPsANGBbsKgYVfPyfzjvJTLh7XBsoe \
  --foreman-proxy-oauth-consumer-secret=vXiCcZmJ4eeBaqP35krZDdpPhVjNqree

