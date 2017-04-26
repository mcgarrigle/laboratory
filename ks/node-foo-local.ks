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

part /boot --size=1024 --ondisk=sda
part pv.01 --size=1    --ondisk=sda --grow

volgroup linux pv.01

logvol /              --fstype=ext4 --name=root          --vgname=linux --size=10240
logvol /home          --fstype=ext4 --name=home          --vgname=linux --size=5120
logvol /tmp           --fstype=ext4 --name=tmp           --vgname=linux --size=5120
logvol /var           --fstype=ext4 --name=var           --vgname=linux --size=2048 --grow
logvol /var/log       --fstype=ext4 --name=var_log       --vgname=linux --size=10240
logvol /var/log/audit --fstype=ext4 --name=var_log_audit --vgname=linux --size=1024

text
reboot --eject

%packages --ignoremissing
yum
dhclient
wget
vim
@Core
%end
