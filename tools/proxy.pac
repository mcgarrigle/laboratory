
function FindProxyForURL(url, host) {
  if (shExpMatch(host, "*.foo.local"))
  {
    return "PROXY 127.0.0.1:9090";
  }
  return "DIRECT";
}
