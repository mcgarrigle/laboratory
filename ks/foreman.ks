# Foreman server kickstart
#
# https://goo.gl/NxsKBl

cdrom
install

lang en
keyboard uk
skipx

network --noipv6 --bootproto static --ip 10.0.30.11 --netmask 255.255.255.0 --hostname foreman.foo.local

rootpw "letmein"
authconfig --useshadow --passalgo=sha256 --kickstart

timezone --utc UTC

bootloader --location=mbr --append="nofb quiet splash=quiet" 

zerombr
clearpart --all

part /boot --size=1024 --ondisk=sda
part pv.01 --size=1    --ondisk=sda --grow

volgroup linux pv.01

logvol /        --fstype=ext4 --name=root    --vgname=linux --size=10240
logvol /home    --fstype=ext4 --name=home    --vgname=linux --size=5120
logvol /tmp     --fstype=ext4 --name=tmp     --vgname=linux --size=5120
logvol /var     --fstype=ext4 --name=var     --vgname=linux --size=2048 --grow
logvol /var/log --fstype=ext4 --name=var_log --vgname=linux --size=10240

text
reboot --eject

%packages --ignoremissing
yum
wget
vim
@Core
%end
