
# copy into /etc/profile.d/

export http_proxy="http://10.0.30.10:9090"
export https_proxy="$http_proxy"
export no_proxy="localhost,127.0.0.1,.foo.local"
