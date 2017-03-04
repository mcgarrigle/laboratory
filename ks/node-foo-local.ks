# node kicksrart
#
# the file also at:
# curl -L https://goo.gl/oX4Qd2

cdrom
install

lang en
keyboard uk
skipx

network --noipv6 --bootproto dhcp --hostname node.foo.local

rootpw "letmein"
authconfig --useshadow --passalgo=sha256 --kickstart

timezone --utc UTC

bootloader --location=mbr --append="nofb quiet splash=quiet" 

zerombr
clearpart --all

